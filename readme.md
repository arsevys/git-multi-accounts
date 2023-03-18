
# DEscripcion

Este tutorial habla de como se puede manejar varias cuentas por modalidad de ssh y el cambio seria por switch


Primero debes tener claro la terminal que se usa, en este caso
usare windows con git bash ,

Git Bash internamente precarga datos antes de abrir su consola

y lo que precarga esta en un archivo .bashrc , este archivo puede variar porque puede que estes usando otro como zsh


puede que al veces no exista y tengas que crearlo, en el gitbash ejecutar

```
vim ~/.bashrc
```
copiar el contenido de "segunda-forma/comando.sh" y pegarlo en el archivo
bashrc

ahora que se tiene 

debes saber como se enlaza un ssh , para eso siempre se genera desde la computadora un ssh , y este se afilia en github cloud

```
 ssh-keygen -t rsa -b 4096 "ssh_local"
```
El resultado de ese comando deberia ser algo asi

![Alt text](./assets/foto1.png?raw=true "Optional Title")

se genera dos archivos el publico (id_rsa.pub) y la llave privada(id_rsa)

con esto solo tenemos como que el token para que podamos usarlo cuando queremos conectarno con algun prveedor de git, pero todavia falta algo mas .


Si bien tenemos el token (clave ssh) , a git tenemoss que indicarle a que dominio nos conectaremos, y que token se deberia usar, y todo esta en un archivo de ssh config ,

de hecho el config tiene un contenido parecido a este
```
Host adathink
    User git 
    Hostname github.com 
    PreferredAuthentications publickey 
    IdentityFile /d/arsevys
```

el problema es que por default git solo te permite por archivo usar un dominio , es decir puedestener , gitlab, github juntos y funciona bien , pero si hablamos de 2 cuentas de gihub , no se puede porque habla conflicto por el host, aparte git te oblicar queel Host sea el dominio del provedor, y no puedes crear mas de 1 Host igual , por eso es que es el limite en ese archivo


Aca empieza la solucion :
La solucion es crear varios archivos config, cada archivo contendra la configuracion del repositorio que se desea conectar

Todo sera dentro ~/.ssh

ahi crearemos 2 carpetas : uno para guardar las llaves privada y publicas que se generen y el otro para las config

carpeta 1 : keyconfig (configs (hostname del provedor y referencia de la clave ssh))
carpeta 2 : keys (claves ssh)

![Alt text](./assets/foto2.png?raw=true "Optional Title")

ahora cada afiliacion es importante ponerle un nombre , por ejemplo le llamare arsevys, a la afiliacion de mi cuenta de github 

Procedo a crear un archivo dentro de la carpeta keyconfig con el nombre arsevys, no se usa extensiones
![Alt text](./assets/foto3.png?raw=true "Optional Title")

Luego su contenido , es lo unico que puede variar sobre todo en el host , dejare ejemplos de algunos provedores de git paara que les ayude

en este ocacion usare github entoncs el contenido del archivo nuevo "arsevys" debe ser asi

```
Host github.com
    User git 
    Hostname github.com 
    PreferredAuthentications publickey 
    IdentityFile ~/.ssh/keys/arsevys
```
aca entonces , cuando intentos hacer un clone en git , buscara en el config , que ese dominio haga match con el Host github.com . y ahi le indicamos (IdentityFile) que para completar la conexion que use el token generado son el ssh-keygen 

Si bien ven que la ruta dice ~/.ssh/keys/arsevys , entonces eso todavia no existe , ahora vamos a renombras nuestras keys generadas al inicio del video y lo moveremos a la carpeta keys

![Alt text](./assets/foto4.png?raw=true "Optional Title")

Si bien el procedimiento manual es un poco tedioso , pero la flexibilidad de uso va a valer un monton .

Con esto las tareas completadas serian :
- Crear las llaves ssh
- Afiliar la llave publico al provedor de git que se use
- Configura en el bashrc  (este solo se hace una unica vez)
- tener un nombre de toda la config , el mio es asevys (no debe tener espacios)
- renombrar las llaves con el nombre de la config y mover a la carpeta keys
- crear un keyconfig, para la configuracion, debe tener el mismo nombre "arsevys", puedes usar otro pero debe aplicarse para toda la configuracion

ahora que ya se tiene todo listo :
Debemos acordarnos siempre al usar para esa configuracion, solo con el nombre "arsevys" .

Entonces cada vez que queremos conectarnos con esa repo en nuestro 
git bash usamos :

```
ssh_git arsevys
```
![Alt text](./assets/foto5.png?raw=true "Optional Title")

y Listo , si hacemos un git clone nos pedira solo las credenciales de las llaves generados

![Alt text](./assets/foto6.png?raw=true "Optional Title")

REcuerden que existe un config (este se crea en el ~/.ssh)general donde se guardan los host por default en ssh , tambien pueden hacer uso de eso  si desean. jeje