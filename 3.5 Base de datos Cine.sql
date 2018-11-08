create database Cine;
use Cine;

create table Clasificacion(cveClas smallint not null, 
			    		   descripcion varchar(30),
						   constraint CinesPK primary key(cveClas));

create table Peliculas(cvePelicula smallint not null,
					   cveClas smallint not null,
					   titulo varchar(30),
					   genero varchar(15),
					   AñoProduccion date,
					   paisDeOrigen varchar(10),					   
					   Duracion datetime,
					   subtitulos varchar(10),
					   Resumen varchar(100),
					   constraint PeliculaPK primary key(cvePelicula),
					   constraint PeliculaFK1 foreign key (cveClas) references Clasificacion(cveClas));

create table Miembros(RFC varchar(15) not null,
				      Nombre varchar(30),
					  nacionalidad varchar(15),
					  peliculasDirigidas int,
					  peliculasActuadas int,
					  constraint MiembrosPK primary key(RFC));

create table Directores(RFC varchar(15) not null,
					    cvePelicula smallint not null,
						constraint DirectoresPK primary key(RFC, cvePelicula),
						constraint DirectoresFK1 foreign key(RFC) references Miembros(RFC),
						constraint DirectoresFK2 foreign key(cvePelicula) references Peliculas(cvePelicula));

create table Actores(RFC varchar(15) not null,
					 cvePelicula smallint not null,
					 personaje varchar(30),
					 constraint ActoresPK primary key(RFC, cvePelicula),
					 constraint ActoresFK1 foreign key(RFC) references Miembros(RFC),
					 constraint ActoresFK2 foreign key(cvePelicula) references Peliculas(cvePelicula));

create table Opinion(idOpinion smallint not null,
					 cvePelicula smallint not null,
					 nombre varchar(30),
					 edad int,
					 fecha date,
				     calificacion varchar(30),
					 opinion varchar(40),
					 constraint OpinionPK primary key(idOpinion, cvePelicula),
					 constraint OpinionFK1 foreign key(cvePelicula) references Peliculas(cvePelicula));

create table Idiomas(idIdioma smallint not null,
					 idioma varchar(20),
					 constraint IdiomasPK primary key(idIdioma));

create table Audio(cvePelicula smallint not null,
				   idIdioma smallint not null,
				   constraint AudioPK primary key(cvePelicula, idIdioma),
			       constraint AudioFK1 foreign key(cvePelicula) references Peliculas(cvePelicula),
				   constraint AudioFK2 foreign key(idIdioma) references Idiomas(idIdioma));

create table CinesExisten(cveCine smallint not null,
						  nombre varchar(30),
				          telefono int,
				          direccion varchar (20),
				          constraint CinesExistenPK primary key(cveCine));

create table Salas(numeroSala smallint not null,
				   cveCine smallint not null,
				   nombre varchar(30),
				   asientos int,
				   constraint SalasPK primary key(numeroSala, cveCine),
				   constraint SalasFK1 foreign key(cveCine) references CinesExisten(cveCine));

create table Promociones(cvePromocion smallint not null,
						 descripcion varchar(30),
						 descuento money,
						 constraint PromocionesPK primary key(cvePromocion));

create table Funciones(idFuncion Smallint not null,
					   dia date,
					   horaInicio datetime,
					   cvePelicula smallint,
					   cvePromocion smallint,
					   numeroSala smallint,
					   cveCine smallint,
					   constraint FuncionesPK primary key(IdFuncion),
					   constraint FuncionesFK1 foreign key (numeroSala, CveCine) references Salas(numeroSala, CveCine),
					   constraint FuncionesFK2 foreign key (cvePelicula)references Peliculas(cvePelicula),
					   constraint FuncionesFK3 foreign key(cvePromocion) references Promociones(cvePromocion));

create table Ventas(idFuncion smallint not null,
				    numeroSala smallint not null,
					cveCine smallint not null,
					lugaresOcupados int,
					lugaresDisponibles int,
					constraint VentasPK primary key(idFuncion, numeroSala, cveCine),
					constraint VentasFK1 foreign key(idFuncion) references Funciones(idFuncion),
					constraint VentasFK2 foreign key(numeroSala, CveCine) references Salas(numeroSala, CveCine));
drop table Ventas;