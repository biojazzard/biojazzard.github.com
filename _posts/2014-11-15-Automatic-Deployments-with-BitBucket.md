---
layout: post
title: Automatic Deployments with BitBucket
---

*Unas notas de como automatizar el deploy de sitios web con git y bitbucket hooks.*

Este artículo está inspirado en este otro [artículo](http://brandonsummers.name/blog/2012/02/10/using-bitbucket-for-automated-deployments/).

# Objetivo

Desarollamos un sitio web. Al hacer commit al proyecto web, es publicado automáticamente.

# Necesario tener o saber

* Local: Desarrollar un proyecto usando GIT.
	+ Software:
		- [GIT](http://git-scm.com/)
		- [SSH](http://www.openssh.com/)
* Servidor: Donde se publica.
	+ Software:
		- [Apache](http://www.apache.org/)
		- [PHP](http://php.net/)
		- [GIT](http://git-scm.com/)
		- [SSH](http://www.openssh.com/)
	+ Cuenta con acceso SSH en el servidor.
* Repositorio:
	+ Cuenta en:
		- [bitbucket](https://bitbucket.org/) ó
		- [github](https://github.com/)

## Flujo de Trabajo

Básicamente lo que queremos es que cuando hagamos en nuestra máquina local de desarrollo:

```git commit``` (consolidar el proyecto) + ```git push``` (subir cambios al repositorio)

El proyecto se actualice automáticamente en [http://domain.com](http://domain.com) 

## Ahorro

Repetir una secuencia de tareas repetidamente.

Queremos que nuestro servidor de destino haga algo automaticamente, y evitarnos hacer a mano cosas como:

```git pull``` (traer los cambiso del repositorio === actualizar el proyecto en el web)

El problema es que para ejecutar ese simple comando, haya que hacer antes:

```bash
# Entrar al servidor
$ ssh user:domain.com
# Ir al directorio del proyecto
$ cd /home/machine/domains/domain.com/html
# Ver cómo estamos
$ git status
# Descartar cambios locales
$ git reset --hard HEAD
# Actualizar web
$ git pull origin master
```
Cada vez que queramos mostrar cambios.... >_<

Teniendo en cuenta, que requiere introducir tanto el *password* del servidor, como el *passphrase* de tu clave.

# Procedimiento

## Necesitamos:

* Usar [bitbucket](https://bitbucket.org/) para alojar nuestro repositorio. 
* Utilizar los [hooks](https://confluence.atlassian.com/display/BITBUCKET/POST+hook+management) de [bitbucket](https://bitbucket.org/)
* Configurar y añadir al proyecto, el archivo [deploy.php](#deploy). Tambien disponible como [gist:deploy.php](https://gist.github.com/c0123f6797aaeb935ccd.git)
* Crear las claves, añadirlas a bitbucket y establecer los permisos necesarios en el servidor de destino.

### Aloja tu proyecto en [bitbucket](https://bitbucket.org/)

Se escapa del alcance del post, sigue las instrucciones en la propia web, es muy sencillo.

### Creación de un hook para tu proyecto en bitbucket:

La configuración de todo esto, en bitbucket: ```Tu Proyecto > Settings > Hooks```

```
# La URL de configuración de los hooks es algo así:
# user.name: tu nombre de usuario de [bitbucket](https://bitbucket.org/)
# project.name: tu proyecto.
https://bitbucket.org/user.name/project.name/admin/hooks

```

* Suponiendo que publicas la web en [domain.com](http://domain.com/)

```
# URL para tu hook;
http://domain.com/deploy.php

```

### Archivo ```deploy.php```

Lo deberás añadir a la raíz de tu proyecto, y no olvides de ```git add deploy.php``` para que no se quede fuera.

<a id="deploy"></a>

```php
<?php

# Originally seen here: 'Using Bitbucket for Automated Deployments'
# http://brandonsummers.name/blog/2012/02/10/using-bitbucket-for-automated-deployments/

# Is it safe servers time ?
#date_default_timezone_set('America/Los_Angeles');

class Deploy {
	/**
	* A callback function to call after the deploy has finished.
	*
	* @var callback
	*/

	public $post_deploy;
	/**
	* The name of the file that will be used for logging deployments. Set to * FALSE to disable logging.
	*
	* @var string 
	*/

	private $_log = 'deployments.log';
	/**
	* The timestamp format used for logging.
	*
	* @link http://www.php.net/manual/en/function.date.php
	* @var string
	*/

	private $_date_format = 'Y-m-d H:i:sP';
	/**
	* The name of the branch to pull from.
	*
	* @var string
	*/

	private $_branch = 'master';
	/**
	* The name of the remote to pull from.
	*
	* @var string
	*/

	private $_remote = 'origin';
	/**
	* The directory where your website and git repository are located, can be * a relative or absolute path
	*
	* @var string
	*/
	private $_directory;
	/** * Sets up defaults.
	*
	* @param string $directory Directory where your website is located
	* @param array $data Information about the deployment
	*/

	public function __construct ($directory, $options = array()) {
		// Determine the directory path
		$this->_directory = realpath($directory).DIRECTORY_SEPARATOR;

		$available_options = array('log', 'date_format', 'branch', 'remote');
		foreach ($options as $option => $value) {
			if (in_array($option, $available_options)) {
				$this->{'_'.$option} = $value; }
			} $this->log('Attempting deployment...');
		}

	/**
	* Writes a message to the log file.
	*
	* @param string $message The message to write
	* @param string $type The type of log message (e.g. INFO, DEBUG, ERROR, etc.)
	*/
	
	public function log($message, $type = 'INFO') {

		if ($this->_log) {
			// Set the name of the log file
				$filename = $this->_log;

			if ( ! file_exists($filename)) {

				// Create the log file
				file_put_contents($filename, '');
				
				// Allow anyone to write to log files
				chmod($filename, 0666); }
				
				// Write the message into the log file
				// Format: time --- type: message
				file_put_contents($filename, date($this->_date_format).' --- '.$type.': '.$message.PHP_EOL, FILE_APPEND);
			} 

		}
		/**
		* Executes the necessary commands to deploy the website.
		*/
		
		public function execute() {
			try {
				// Make sure we're in the right directory
				//exec('cd '.$this->_directory, $output);
				chdir($this->_directory);
				$this->log('Changing working directory... '.implode(' ', $output));
				// Discard any changes to tracked files since our last deploy
				exec('git reset --hard HEAD', $output);
				$this->log('Reseting repository... '.implode(' ', $output)); // Update the local repository
				
				exec('git pull '.$this->_remote.' '.$this->_branch, $output);
				$this->log('Pulling in changes... '.implode(' ', $output));
				
				// Secure the .git directory
				exec('chmod -R og-rx .git');
				$this->log('Securing .git directory... ');
				if (is_callable($this->post_deploy)) {
					call_user_func($this->post_deploy, $this->_data);
				}
				$this->log('Deployment successful.');
			} catch (Exception $e) {
				$this->log($e, 'ERROR');
		}
	}
}
// This is just an example
$deploy = new Deploy('/home/machine/domains/domain.com/html');
$deploy->post_deploy = function() use ($deploy) {
	// hit the wp-admin page to update any db changes
	//exec('curl http://www.foobar.com/wp-admin/upgrade.php?step=upgrade_db');
	$deploy->log('Biojazzard´s GIT PULL ... ');
};
// Doit
$deploy->execute();
?>
```

### Configuración de ```deploy.php```en tu proyecto web.

* Coloca [deploy.php](#deploy) en la raíz de tu proyecto web, recuerda que has configurado el hook para que llame a:

```
# Hook URL
http://domain.com/deploy.php

```

* Configura [deploy.php](#deploy)

Configura tu branch del proyecto.

```php
<?php
// ...
private $_branch = 'master';
?>
```

Configura el origen del repositorio.

```php
<?php
// ...
private $_remote = 'origin';
?>
```

Y lo más importante: la ruta al proyecto: depende de tu servidor y suele ser del tipo:

```php
<?php
// ...
$deploy = new Deploy('/home/machine/domains/domain.com/html');
?>
```

# Configuración SSH, Deployment Keys y Permisos

En estos momentos, ya podrás hacer un ```git commit``` y ```git push```: ```deploy.php`` será atacado, pero no se te actualizará el proyecto. >_<

Queda:

## SSH

* Si tu par de keys, tiene una *passphrase*, no te servirá. Para ello:

Conectate a tu servidor vía SSH y genera un par, no establezcas ninguna *passphrase*

```bash
$ ssh-keygen -t rsa
```

Copia el contenido de la clave que se te muestra al abrir la clave pública:

```bash
$ cat ~/.ssh/id_rsa.pub
```

## Deployment Keys en bitbucket

Y pegalo en el contenido de la *key* que generes para el proyecto: para ello vete a bitbucket, abre tu proyecto, vete a ```Tu proyecto > Settings > Deployment Keys```

```
# La URL es del tipo:
https://bitbucket.org/biojazzard/demo.psicotecnico/admin/deploy-keys
```

## Permisos

Lo único que falta, es hacer que tu servidor *Apache*, tenga el permiso necesario para ver tu clave pública, es necesario entonces que asignes los permisos necesarios a la carpeta ```.ssh``

```bash
$ chown -R www-data:www-data .ssh
```

En mi caso el usuario apache es ```www-data``` en tu caso puede ser diferente:

```bash
$ chown -R apache:apache .ssh
```

# Consejos

* Mira el log ```deployment.log``` con frecuencia: te puede dar pistas de o que esté pasando.
* En estos casos los asuntos suelen venir siempre de permisos *chungos*.

## Recursos

* [deploy.php](https://gist.github.com/biojazzard/c0123f6797aaeb935ccd)

## Más información

* [bitbucket-for-automated-deployments](http://brandonsummers.name/blog/2012/02/10/using-bitbucket-for-automated-deployments/)
https://confluence.atlassian.com/display/BITBUCKET/POST+hook+management

* [Add an SSH key to an account](https://confluence.atlassian.com/display/BITBUCKET/Add+an+SSH+key+to+an+account#AddanSSHkeytoanaccount-Testingwhichkeyyouaresending)

* [Set up SSH for Git and Mercurial on Mac OSX/Linux](https://confluence.atlassian.com/pages/viewpage.action?pageId=270827678)

* [Configure multiple SSH identities for GitBash, Mac OSX, & Linux](https://confluence.atlassian.com/pages/viewpage.action?pageId=271943168#ConfiguremultipleSSHidentitiesforGitBash,MacOSX,&Linux-LoadeachkeyintotheappropriateBitbucketaccount)
