-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2022-09-14 15:26:46 AEST
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c

SET ECHO ON
SPOOL monh_schema_output.txt

DROP TABLE client CASCADE CONSTRAINTS;

DROP TABLE combo_detail CASCADE CONSTRAINTS;

DROP TABLE employee CASCADE CONSTRAINTS;

DROP TABLE job CASCADE CONSTRAINTS;

DROP TABLE purpose CASCADE CONSTRAINTS;

DROP TABLE quote CASCADE CONSTRAINTS;

DROP TABLE trailer CASCADE CONSTRAINTS;

DROP TABLE trailer_class CASCADE CONSTRAINTS;

DROP TABLE trailer_type CASCADE CONSTRAINTS;

DROP TABLE truck CASCADE CONSTRAINTS;

DROP TABLE truck_class CASCADE CONSTRAINTS;

DROP TABLE truck_trailer_purpose CASCADE CONSTRAINTS;

DROP TABLE truck_type CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE client (
    cli_no       NUMBER(7) NOT NULL,
    cli_fname    VARCHAR2(50) NOT NULL,
    cli_lname    VARCHAR2(50) NOT NULL,
    cli_bus_name VARCHAR2(100),
    cli_address  VARCHAR2(150) NOT NULL,
    cli_phone_no CHAR(10) NOT NULL
);

COMMENT ON COLUMN client.cli_no IS
    'The unique client number that identifies each client in the database';

COMMENT ON COLUMN client.cli_fname IS
    'The Client''s First Name';

COMMENT ON COLUMN client.cli_lname IS
    'The Client''s  Last Name';

COMMENT ON COLUMN client.cli_bus_name IS
    'The Client''s business name (if applicable). Optional in the case that the client is purchasing independently. ';

COMMENT ON COLUMN client.cli_address IS
    'The Client''s address ';

COMMENT ON COLUMN client.cli_phone_no IS
    'The Client''s phone number';

ALTER TABLE client ADD CONSTRAINT client_pk PRIMARY KEY ( cli_no );

CREATE TABLE combo_detail (
    truck_trailer_combo_code CHAR(3 CHAR) NOT NULL,
    truck_vin                CHAR(16) NOT NULL,
    trailer_code             CHAR(5) NOT NULL
);

COMMENT ON COLUMN combo_detail.truck_trailer_combo_code IS
    'a 3 character code representing the combination of a truck and trailer';

COMMENT ON COLUMN combo_detail.truck_vin IS
    'vehicle identification number ';

COMMENT ON COLUMN combo_detail.trailer_code IS
    'a 5 character long code identifying a trailer';

ALTER TABLE combo_detail ADD CONSTRAINT truck_and_trailer_pk PRIMARY KEY ( truck_trailer_combo_code );

CREATE TABLE employee (
    emp_no         NUMBER(7) NOT NULL,
    emp_fname      VARCHAR2(50) NOT NULL,
    emp_lname      VARCHAR2(50) NOT NULL,
    emp_phone_no   CHAR(10) NOT NULL,
    emp_tfn        NUMBER(9) NOT NULL,
    emp_salary     NUMBER(9, 2) NOT NULL,
    emp_role       VARCHAR2(10) NOT NULL,
    emp_no_managed NUMBER(7)
);

ALTER TABLE employee
    ADD CONSTRAINT chk_emprole CHECK ( emp_role IN ( 'C', 'D', 'G', 'MA', 'ME' ) );

COMMENT ON COLUMN employee.emp_no IS
    'The employee number';

COMMENT ON COLUMN employee.emp_fname IS
    'Employee first name';

COMMENT ON COLUMN employee.emp_lname IS
    'employee last name';

COMMENT ON COLUMN employee.emp_tfn IS
    'employee tax file number';

COMMENT ON COLUMN employee.emp_salary IS
    'employee salary';

COMMENT ON COLUMN employee.emp_role IS
    'Employee role ';

COMMENT ON COLUMN employee.emp_no_managed IS
    'The employee number';

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( emp_no );

CREATE TABLE job (
    job_no                         NUMBER(4) NOT NULL,
    job_pickup_date_time           DATE NOT NULL,
    job_intended_dropoff_date_time DATE NOT NULL,
    job_actual_dropoff_date_time   DATE NOT NULL,
    job_cost                       NUMBER(10, 2),
    job_cli_pay_date               DATE NOT NULL,
    quote_no                       NUMBER(4) NOT NULL,
    emp_no_mech                    NUMBER(7) NOT NULL,
    emp_no_driver                  NUMBER(7) NOT NULL,
    truck_trailer_purpose_no       NUMBER(7) NOT NULL
);

COMMENT ON COLUMN job.job_no IS
    'Unique Job number to identify each job. ';

COMMENT ON COLUMN job.job_pickup_date_time IS
    'Job pickup date and time of truck and trailer ';

COMMENT ON COLUMN job.job_intended_dropoff_date_time IS
    'Job intended dropoff  date and time of truck and trailer ';

COMMENT ON COLUMN job.job_actual_dropoff_date_time IS
    'Job actual dropoff  date and time of truck and trailer ';

COMMENT ON COLUMN job.job_cost IS
    'Cost of the job if different to the provided quote (optional)';

COMMENT ON COLUMN job.job_cli_pay_date IS
    'Date the client  has paid for the job (have placed as non-mandatory as client can choose to pay after completion of job)';

COMMENT ON COLUMN job.quote_no IS
    'Unique number that identifies each quote in the database (4 numeric long)';

COMMENT ON COLUMN job.emp_no_mech IS
    'The employee number';

COMMENT ON COLUMN job.emp_no_driver IS
    'The employee number';

COMMENT ON COLUMN job.truck_trailer_purpose_no IS
    'surrogate key for truck_trailer_purchase unique identifying number
(surrogate pk)';

CREATE UNIQUE INDEX job__idx ON
    job (
        quote_no
    ASC );

CREATE UNIQUE INDEX job__idxv1 ON
    job (
        truck_trailer_purpose_no
    ASC );

ALTER TABLE job ADD CONSTRAINT job_pk PRIMARY KEY ( job_no );

CREATE TABLE purpose (
    purpose_no   CHAR(3 CHAR) NOT NULL,
    purpose_desc VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN purpose.purpose_no IS
    'a 3 character long code representing purpose number';

COMMENT ON COLUMN purpose.purpose_desc IS
    'a short description regarding the purpose for hiring the truck and trailer';

ALTER TABLE purpose ADD CONSTRAINT purpose_pk PRIMARY KEY ( purpose_no );

CREATE TABLE quote (
    quote_no              NUMBER(4) NOT NULL,
    quote_pref_start_date DATE NOT NULL,
    quote_purpose_desc    VARCHAR2(150) NOT NULL,
    quote_no_day_req      NUMBER(3) NOT NULL,
    quote_prep_date       DATE NOT NULL,
    quote_cost            NUMBER(10, 2) NOT NULL,
    cli_no                NUMBER(7) NOT NULL,
    purpose_no            CHAR(3 CHAR) NOT NULL
);

COMMENT ON COLUMN quote.quote_no IS
    'Unique number that identifies each quote in the database (4 numeric long)';

COMMENT ON COLUMN quote.quote_pref_start_date IS
    'The preferred starting date that the client has requested for the job and noted by the clerk in the quote database.';

COMMENT ON COLUMN quote.quote_purpose_desc IS
    'Short description given by client of the purpose for hiring the truck/trailer';

COMMENT ON COLUMN quote.quote_no_day_req IS
    'client amount of days requested for quote ';

COMMENT ON COLUMN quote.quote_prep_date IS
    'The date the quote was prepared by the clerk';

COMMENT ON COLUMN quote.quote_cost IS
    'The quoted cost for the job ';

COMMENT ON COLUMN quote.cli_no IS
    'The unique client number that identifies each client in the database';

COMMENT ON COLUMN quote.purpose_no IS
    'a 3 character long code representing purpose number';

CREATE UNIQUE INDEX quote__idx ON
    quote (
        purpose_no
    ASC );

ALTER TABLE quote ADD CONSTRAINT quote_pk PRIMARY KEY ( quote_no );

CREATE TABLE trailer (
    trailer_code          CHAR(5) NOT NULL,
    trailer_purchase_cost NUMBER(9) NOT NULL,
    trailer_purchase_date DATE NOT NULL,
    trailer_model         VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN trailer.trailer_code IS
    'a 5 character long code identifying a trailer';

COMMENT ON COLUMN trailer.trailer_purchase_cost IS
    'Cost of purchase of trailer';

COMMENT ON COLUMN trailer.trailer_purchase_date IS
    'Date of purchase of trailer';

COMMENT ON COLUMN trailer.trailer_model IS
    'The model of the trailer ';

ALTER TABLE trailer ADD CONSTRAINT tr_pk PRIMARY KEY ( trailer_code );

CREATE TABLE trailer_class (
    trailer_code            CHAR(5 CHAR) NOT NULL,
    trailer_daily_hire_rate NUMBER(9, 2) NOT NULL
);

COMMENT ON COLUMN trailer_class.trailer_code IS
    'a 5 character long code identifying a trailer';

COMMENT ON COLUMN trailer_class.trailer_daily_hire_rate IS
    'the daily hire rate for trailer';

ALTER TABLE trailer_class ADD CONSTRAINT trailer_class_pk PRIMARY KEY ( trailer_code );

CREATE TABLE trailer_type (
    trailer_model         VARCHAR2(100) NOT NULL,
    trailer_class_name    CHAR(2 CHAR) NOT NULL,
    trailer_manufacturer  VARCHAR2(100) NOT NULL,
    trailer_dimensions    VARCHAR2(20 CHAR) NOT NULL,
    trailer_load_capacity NUMBER(10, 2) NOT NULL,
    trailer_code          CHAR(5 CHAR) NOT NULL
);

COMMENT ON COLUMN trailer_type.trailer_model IS
    'The model of the trailer ';

COMMENT ON COLUMN trailer_type.trailer_class_name IS
    'the class of the trailer';

COMMENT ON COLUMN trailer_type.trailer_manufacturer IS
    'The manufacturer of the trailer';

COMMENT ON COLUMN trailer_type.trailer_dimensions IS
    'the size in area of the trailer';

COMMENT ON COLUMN trailer_type.trailer_load_capacity IS
    'The weight in which a trailer can transport';

COMMENT ON COLUMN trailer_type.trailer_code IS
    'a 5 character long code identifying a trailer';

ALTER TABLE trailer_type ADD CONSTRAINT trailer_typev1_pk PRIMARY KEY ( trailer_model );

CREATE TABLE truck (
    truck_vin               CHAR(16) NOT NULL,
    truck_rego_no           CHAR(9 CHAR) NOT NULL,
    truck_km_travelled      NUMBER(6) NOT NULL,
    truck_last_service_date DATE NOT NULL,
    truck_type_no           NUMBER(7) NOT NULL
);

COMMENT ON COLUMN truck.truck_vin IS
    'vehicle identification number ';

COMMENT ON COLUMN truck.truck_rego_no IS
    '9 character long registration number for a truck';

COMMENT ON COLUMN truck.truck_km_travelled IS
    'Odometer reading of specific truck (determines km travelled)';

COMMENT ON COLUMN truck.truck_type_no IS
    'The unique number to identify the truck type 
';

ALTER TABLE truck ADD CONSTRAINT truck_pk PRIMARY KEY ( truck_vin );

CREATE TABLE truck_class (
    truck_class_no         NUMBER(7) NOT NULL,
    truck_driver_hire_rate NUMBER(9, 2) NOT NULL,
    truck_daily_hire_rate  NUMBER(9, 2) NOT NULL
);

COMMENT ON COLUMN truck_class.truck_class_no IS
    'The unique number to identify truck class';

COMMENT ON COLUMN truck_class.truck_driver_hire_rate IS
    'The hire rate for the truck driver';

COMMENT ON COLUMN truck_class.truck_daily_hire_rate IS
    'The daily hire rate of the truck';

ALTER TABLE truck_class ADD CONSTRAINT truck_class_pk PRIMARY KEY ( truck_class_no );

CREATE TABLE truck_trailer_purpose (
    truck_trailer_purpose_no NUMBER(7) NOT NULL,
    purpose_no               CHAR(3 CHAR) NOT NULL,
    truck_trailer_combo_code CHAR(3 CHAR) NOT NULL
);

COMMENT ON COLUMN truck_trailer_purpose.truck_trailer_purpose_no IS
    'surrogate key for truck_trailer_purchase unique identifying number
(surrogate pk)';

COMMENT ON COLUMN truck_trailer_purpose.purpose_no IS
    'a 3 character long code representing purpose number';

COMMENT ON COLUMN truck_trailer_purpose.truck_trailer_combo_code IS
    'a 3 character code representing the combination of a truck and trailer';

ALTER TABLE truck_trailer_purpose ADD CONSTRAINT combination_pk PRIMARY KEY ( truck_trailer_purpose_no );

ALTER TABLE truck_trailer_purpose ADD CONSTRAINT truck_trailer_purpose_no_nk UNIQUE ( purpose_no,
                                                                                      truck_trailer_combo_code );

CREATE TABLE truck_type (
    truck_type_no  NUMBER(7) NOT NULL,
    truck_make     VARCHAR2(100) NOT NULL,
    truck_model    VARCHAR2(100) NOT NULL,
    truck_class_no NUMBER(7) NOT NULL
);

COMMENT ON COLUMN truck_type.truck_type_no IS
    'The unique number to identify the truck type 
';

COMMENT ON COLUMN truck_type.truck_make IS
    'The make/manufacturer of the truck ';

COMMENT ON COLUMN truck_type.truck_model IS
    'The model of the truck ';

COMMENT ON COLUMN truck_type.truck_class_no IS
    'The unique number to identify truck class';

ALTER TABLE truck_type ADD CONSTRAINT truck_type_pk PRIMARY KEY ( truck_type_no );

ALTER TABLE quote
    ADD CONSTRAINT client_quote FOREIGN KEY ( cli_no )
        REFERENCES client ( cli_no );

ALTER TABLE employee
    ADD CONSTRAINT employee_employee FOREIGN KEY ( emp_no_managed )
        REFERENCES employee ( emp_no );

ALTER TABLE job
    ADD CONSTRAINT employeeclerk_job FOREIGN KEY ( emp_no_driver )
        REFERENCES employee ( emp_no );

ALTER TABLE job
    ADD CONSTRAINT employeemech_job FOREIGN KEY ( emp_no_mech )
        REFERENCES employee ( emp_no );

ALTER TABLE quote
    ADD CONSTRAINT purpose_quote FOREIGN KEY ( purpose_no )
        REFERENCES purpose ( purpose_no );

ALTER TABLE job
    ADD CONSTRAINT quote_job FOREIGN KEY ( quote_no )
        REFERENCES quote ( quote_no );

ALTER TABLE combo_detail
    ADD CONSTRAINT trailer_combodetail FOREIGN KEY ( trailer_code )
        REFERENCES trailer ( trailer_code );

ALTER TABLE trailer_type
    ADD CONSTRAINT trailerclass_trailer_type FOREIGN KEY ( trailer_code )
        REFERENCES trailer_class ( trailer_code );

ALTER TABLE trailer
    ADD CONSTRAINT trailertype_trailer FOREIGN KEY ( trailer_model )
        REFERENCES trailer_type ( trailer_model );

ALTER TABLE combo_detail
    ADD CONSTRAINT truck_combodetail FOREIGN KEY ( truck_vin )
        REFERENCES truck ( truck_vin );

ALTER TABLE truck_trailer_purpose
    ADD CONSTRAINT truck_trailer_combo FOREIGN KEY ( truck_trailer_combo_code )
        REFERENCES combo_detail ( truck_trailer_combo_code );

ALTER TABLE truck_type
    ADD CONSTRAINT truckclass_trucktype FOREIGN KEY ( truck_class_no )
        REFERENCES truck_class ( truck_class_no );

ALTER TABLE job
    ADD CONSTRAINT trucktrailerpurpose_job FOREIGN KEY ( truck_trailer_purpose_no )
        REFERENCES truck_trailer_purpose ( truck_trailer_purpose_no );

ALTER TABLE truck
    ADD CONSTRAINT trucktype_truck FOREIGN KEY ( truck_type_no )
        REFERENCES truck_type ( truck_type_no );

ALTER TABLE truck_trailer_purpose
    ADD CONSTRAINT ttpd_tt FOREIGN KEY ( purpose_no )
        REFERENCES purpose ( purpose_no );

SPOOL OFF
SET ECHO OFF


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            13
-- CREATE INDEX                             3
-- ALTER TABLE                             30
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
