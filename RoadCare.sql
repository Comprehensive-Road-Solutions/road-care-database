CREATE DATABASE RoadCare
GO

USE RoadCare
GO

CREATE TABLE departments
(
	id int identity(1,1) NOT NULL,
	name varchar(50) NOT NULL

	CONSTRAINT pk_department_id PRIMARY KEY (id)
)
GO
CREATE TABLE districts
(
	id int identity(1,1) NOT NULL,
	departments_id int NOT NULL,
	name varchar(50) NOT NULL

	CONSTRAINT pk_district_id PRIMARY KEY (id),

	CONSTRAINT fk_districts_departments_id FOREIGN KEY (departments_id)
	REFERENCES departments(id)
)
GO
CREATE TABLE governments_entities
(
	id int identity(1,1) NOT NULL,
	districts_id int NOT NULL,
	ruc varchar(100) NOT NULL,
	name varchar(50) NOT NULL,
	phone int NOT NULL,
	email varchar(100) NOT NULL,
	address varchar(100) NOT NULL

	CONSTRAINT pk_government_entity_id PRIMARY KEY (id),

	CONSTRAINT fK_governments_entities_districts_id FOREIGN KEY (districts_id)
	REFERENCES districts(id)
)
GO
CREATE TABLE workers_areas
(
	id int identity(1,1) NOT NULL,
	governments_entities_id int NOT NULL,
	name varchar(50) NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_worker_area_id PRIMARY KEY (id),

	CONSTRAINT fk_workers_areas_governments_entities_id FOREIGN KEY (governments_entities_id)
	REFERENCES governments_entities(id),

	CONSTRAINT chk_worker_area_state CHECK (state IN ('ELIMINADO', 'ACTIVO'))
)
GO
CREATE TABLE workers_roles
(
	id int identity(1,1) NOT NULL,
	workers_areas_id int NOT NULL,
	name varchar(20) NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_worker_role_id PRIMARY KEY (id),

	CONSTRAINT fk_workers_roles_workers_areas_id FOREIGN KEY (workers_areas_id)
	REFERENCES workers_areas(id),

	CONSTRAINT chk_worker_role_state CHECK (state IN ('ELIMINADO', 'ACTIVO'))
)
GO
CREATE TABLE workers
(
	id int NOT NULL,
	districts_id int NOT NULL,
	governments_entities_id int NOT NULL,
	firstname varchar(50) NOT NULL,
	lastname varchar(50) NOT NULL,
	age int NOT NULL,
	genre varchar(20) NOT NULL,
	phone int NOT NULL,
	email varchar(100) NOT NULL,
	address varchar(100) NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_worker_id PRIMARY KEY (id),

	CONSTRAINT fk_workers_districts_id FOREIGN KEY (districts_id)
	REFERENCES districts(id),

	CONSTRAINT fk_workers_governments_entities_id FOREIGN KEY (governments_entities_id)
	REFERENCES governments_entities(id),

	CONSTRAINT chk_worker_state CHECK (state IN ('SUSPENDIDO', 'INACTIVO', 'ACTIVO'))
)
GO
CREATE TABLE workers_credentials
(
	workers_id int NOT NULL,
	code varchar(50) NOT NULL

	CONSTRAINT pk_worker_credential_workers_id PRIMARY KEY (workers_id),

	CONSTRAINT fk_workers_credentials_workers_id FOREIGN KEY (workers_id)
	REFERENCES workers(id)
)
GO
CREATE TABLE assignments_workers
(
	id int identity(1,1) NOT NULL,
	workers_roles_id int NOT NULL,
	workers_id int NOT NULL,
	start_date date NOT NULL,
	final_date date NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_assignment_worker_id PRIMARY KEY (id),

	CONSTRAINT fk_assignments_workers_workers_roles_id FOREIGN KEY (workers_roles_id)
	REFERENCES workers_roles(id),

	CONSTRAINT fk_assignments_workers_workers_id FOREIGN KEY (workers_id)
	REFERENCES workers(id),

	CONSTRAINT chk_assignment_worker_state CHECK (state IN ('ELIMINADO', 'SUSPENDIDO', 'EXPIRADO', 'VIGENTE'))
)
GO
CREATE TABLE damaged_infrastructures
(
	id int identity(1,1) NOT NULL,
	districts_id int NOT NULL,
	registration_date datetime NOT NULL,
	description varchar(200) NOT NULL,
	address varchar(100) NOT NULL,
	work_date datetime NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_damaged_infrastructure PRIMARY KEY (id),

	CONSTRAINT fk_damaged_infrastructures_districts_id FOREIGN KEY (districts_id)
	REFERENCES districts(id),

	CONSTRAINT chk_damaged_infrastructure_state CHECK (state IN ('DENEGADO', 'EN PROCESO', 'PENDIENTE', 'COMPLETADO'))
)
GO
CREATE TABLE staff
(
	id int identity(1,1) NOT NULL,
	damaged_infrastructures_id int NOT NULL,
	workers_id int NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_staff_id PRIMARY KEY (id),

	CONSTRAINT fk_staff_damaged_infrastructures_id FOREIGN KEY (damaged_infrastructures_id)
	REFERENCES damaged_infrastructures(id),

	CONSTRAINT fk_staff_workers_id FOREIGN KEY (workers_id)
	REFERENCES workers(id),

	CONSTRAINT chk_staff_state CHECK (state IN ('ELIMINADO', 'SUSPENDIDO', 'INACTIVO', 'ACTIVO'))
)
GO
CREATE TABLE citizens
(
	id int NOT NULL,
	profile_url varchar(MAX) NULL,
	firstname varchar(50) NOT NULL,
	lastname varchar(50) NOT NULL,
	age int NOT NULL,
	genre varchar(20) NOT NULL,
	phone int NOT NULL,
	email varchar(100) NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_citizen_id PRIMARY KEY (id),

	CONSTRAINT chk_citizen_state CHECK (state IN ('REPORTADO', 'INACTIVO', 'ACTIVO'))
)
GO
CREATE TABLE citizens_credentials
(
	citizens_id int NOT NULL,
	code varchar(50) NOT NULL

	CONSTRAINT pk_citizen_credential_citizens_id PRIMARY KEY (citizens_id),

	CONSTRAINT fk_citizens_credentials_citizens_id FOREIGN KEY (citizens_id)
	REFERENCES citizens(id)
)
GO
CREATE TABLE publications
(
	id int identity(1,1) NOT NULL,
	citizens_id int NOT NULL,
	publication_date datetime NOT NULL,
	districts_id int NOT NULL,
	ubication varchar(100) NOT NULL,
	description varchar(200) NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_publication_id PRIMARY KEY (id),

	CONSTRAINT fk_publications_citizens_id FOREIGN KEY (citizens_id)
	REFERENCES citizens(id),

	CONSTRAINT fk_publications_districts_id FOREIGN KEY (districts_id)
	REFERENCES districts(id),

	CONSTRAINT chk_publications_state CHECK (state IN ('REPORTADO', 'ELIMINADO', 'PUBLICADO'))
)
GO
CREATE TABLE evidences
(
	id int identity(1,1) NOT NULL,
	publications_id int NOT NULL,
	file_url varchar(MAX) NOT NULL

	CONSTRAINT pk_evidence_id PRIMARY KEY (id),

	CONSTRAINT fk_evidences_publications_id FOREIGN KEY (publications_id)
	REFERENCES publications(id)
)
GO
CREATE TABLE comments
(
	id int identity(1,1) NOT NULL,
	publications_id int NOT NULL,
	citizens_id int NOT NULL,
	shipping_date datetime NOT NULL,
	opinion varchar(100) NOT NULL,
	state varchar(20) NOT NULL

	CONSTRAINT pk_comment_id PRIMARY KEY (id),

	CONSTRAINT fk_comments_publications_id FOREIGN KEY (publications_id)
	REFERENCES publications(id),

	CONSTRAINT fk_comments_citizens_id FOREIGN KEY (citizens_id)
	REFERENCES citizens(id),

	CONSTRAINT chk_comment_state CHECK (state IN ('REPORTADO', 'ELIMINADO', 'ENVIADO'))
)
GO

-- triggers --

CREATE TRIGGER tg_register_data_workers_areas
ON governments_entities FOR INSERT
AS

	SET NOCOUNT ON

	INSERT INTO workers_areas VALUES
	((SELECT inserted.id FROM inserted), 'ADMINISTRACION', 'ACTIVO')

GO
CREATE TRIGGER tg_register_data_workers_roles
ON workers_areas FOR INSERT
AS

	SET NOCOUNT ON

	INSERT INTO workers_roles VALUES
	((SELECT inserted.id FROM inserted), 'SUPERVISOR', 'ACTIVO')

GO
