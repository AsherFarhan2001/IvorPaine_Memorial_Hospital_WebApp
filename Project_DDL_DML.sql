use Hospital;

select * from Consultant;
select * from PATIENT;
select * from JuniorDR;
select * from CAREUNIT;
select * from NursePreHistory;




create table users(
username varchar(20),
password varchar(10),
primary key(username)

);

insert into users VALUES ('asher','12345');

select * from users;

--1)	Specialty
CREATE TABLE Speciality
(
	Spec_Code char(5),
	Name varchar(35) unique,
	levelof int,
	constraint S_PK1 PRIMARY KEY (Spec_Code)
);

--2)	Consultant

CREATE TABLE Consultant
(
	Const_ID char(8),
	Name varchar(35) not null,
	Address varchar(60),
	Billing_Rate 	int,
	Salary int,
	Phone varchar(20) unique,
	DOB varchar(25) not Null,
	Spec_Code char(5),
	position varchar(20),
	constraint c_pk1 PRIMARY KEY (Const_ID),
	constraint fcpk1 FOREIGN KEY (Spec_Code)
	references Speciality(Spec_Code)
);
--Ward
CREATE TABLE WARD
(
	Ward_ID char(5),
	Name varchar(35) unique,
	Floor_no int,
	Capacity int,
	Spec_Code char(5),
	constraint wpk1 PRIMARY KEY (Ward_ID),
	constraint fkp1 FOREIGN KEY (Spec_Code)
	references Speciality(Spec_Code)
);


CREATE TABLE Complaint
(
	COM_CODE int,
	TITLE VARCHAR(20) NOT NULL,
	DESCR VARCHAR(40),
	CONSTRAINT COM_PK PRIMARY KEY(COM_CODE)
);


CREATE TABLE TREATMENT
(
	TRT_CODE char(5),
	NAME VARCHAR(35) NOT NULL,
	DESCR VARCHAR(40),
	CONSTRAINT TRT_PK PRIMARY KEY(TRT_CODE)
);

CREATE TABLE PATIENT
(
	PAT_ID char(8),
	NAME VARCHAR(35) NOT NULL,
	ADDRESS VARCHAR(60),
	Phone VARCHAR(25) unique,
	City varchar(25),
	DOB varchar(25) not Null,
	CONSTRAINT pat_PK PRIMARY KEY(PAT_ID)
);


CREATE TABLE Nurse
(
	Nurse_ID char(8),
	NAME VARCHAR(30) NOT NULL,
	ADDRESS VARCHAR(60),
	TELNO VARCHAR(20) UNIQUE,
	DOB Date not Null,
	NurseType varchar(5),
	HireDate Date not NULL,
	position varchar(20),
	constraint nnnpk1 PRIMARY KEY(Nurse_ID)	
);

CREATE  table NurseShift
(
	Ser_NS int,
	Sis_ID char(8),
	Shift varchar(10) not Null,
	Incharge_ward char(5),
	constraint nspk2 PRIMARY KEY (Ser_NS,Sis_ID,incharge_ward),
	constraint a1 FOREIGN KEY (Sis_ID)
	references  Nurse(Nurse_ID),
	constraint a2 FOREIGN KEY (Incharge_ward)
	references  Ward(Ward_ID)	
);   


CREATE TABLE RegNurse
(
	RNurse_Id char(8),
	SAL int not null,
	bonus int,
	pension int,
	constraint regNqq_pk1 PRIMARY KEY (RNurse_ID),	
	constraint regN_pk1 FOREIGN KEY (RNurse_ID)
	references Nurse(Nurse_ID)
);


CREATE TABLE NonRegNurse
(
	NRNurse_ID char(8),
    rate int not null,
	workHrs int,
	constraint nonregN_asapk1 PRIMARY KEY (NRNurse_ID),
	constraint regNaa_pk1 FOREIGN KEY (NRNurse_ID)
	references Nurse(Nurse_ID)
);


CREATE TABLE CAREUNIT
(
   CU_code char(8),
   ward_ID char(5),
   name varchar(30) not null,
   capacity int,
   Head_Nurse char(8),
   constraint cu_pk PRIMARY KEY(CU_CODE),
   CONSTRAINT cu_fk1 FOREIGN KEY(ward_ID) REFERENCES WARD(WARD_ID),
   CONSTRAINT cu_fk2 FOREIGN KEY(Head_Nurse) REFERENCES RegNurse(RNURSE_ID)
);



CREATE TABLE BED
(
	BedNo int not null,
	bedtype varchar(30),
	sizeOfBed varchar(15),
	CU_Code char(8),
	Ward_No char(5),
	constraint bd_pk PRIMARY KEY(BedNo),
	CONSTRAINT bd_fk1 FOREIGN KEY(CU_Code) REFERENCES CAREUNIT(cu_code),
	CONSTRAINT bd_fk12 FOREIGN KEY(Ward_No) REFERENCES Ward(Ward_ID)
);



CREATE TABLE TEAM
(
	Team_Code char(8),
	Name varchar(30) unique,
	Const_ID char(8),
	constraint tm_pk PRIMARY KEY(Team_code),
	CONSTRAINT tm_fk1 FOREIGN KEY(Const_ID) REFERENCES Consultant(Const_ID)
);



CREATE Table JuniorDR
(
	Doc_ID char(8),
	Name varchar(35) not null,
	ADDRESS varchar(60),
	Salary int,
	Phone varchar(15) unique,
	Positon varchar(20) not null,
	DOB varchar(25) Not NUll,
	constraint jd_pk1 PRIMARY KEY (Doc_ID)
);






CREATE Table NursePreHistory
(
	Ser_NPH int,
	Nurse_ID char(8),
	JoinDate date not Null,
	CU_Code char(8),
	Ward_id char(5),
	constraint NPH PRIMARY KEY (Ser_NPH,Nurse_ID,CU_Code),
	constraint NPH_Fk1 FOREIGN KEY (CU_CODE)
	references CAREUNIT(CU_CODE),
	constraint NPH_Fk12 FOREIGN KEY (Nurse_ID)
	references NURSE(Nurse_ID)
);



CREATE Table Pataint_Incharge
(
	Ser_PatINC int,
	pat_Id char(8),
	Doc_ID char(8),
	Inc_Date  Date not Null,
	constraint pi_pk1 PRIMARY KEY (pat_Id,Ser_PatINC,Doc_ID),
	constraint pi_fk1 FOREIGN KEY (pat_id)
	references Patient(pat_id),
	constraint pi_fk2 FOREIGN KEY (Doc_id)
	references  juniorDr(Doc_id)
);



CREATE Table Medical_Histroy
(
	Serial_no int,
	pat_Id char(8),
	Doc_ID char(8),
	TRT_Code char(5),
	Com_Code int,
	Start_Date  Date not Null,
	End_Date  Date not Null,
	constraint pi_pk15 PRIMARY KEY (Serial_no,pat_Id,Doc_ID,Com_Code,TRT_Code),
	constraint pi_fk15 FOREIGN KEY (pat_id)
	references Patient(pat_id),
	constraint pi_fk25 FOREIGN KEY (Doc_id)
	references  juniorDr(Doc_id),
	constraint pi_fk254 FOREIGN KEY (Com_code)
	references  complaint(COm_code),
	constraint pi_fk255 FOREIGN KEY (trt_code)
	references  Treatment(TRT_Code)

	
);


 CREATE TABLE DOCTEAM_REC
(
	Team_Code char(8),
	Doc_ID char(8),
	joinDate date,
	endDate date,
	constraint DTREC_pk PRIMARY KEY(Team_code,Doc_ID),
	CONSTRAINT DTREC_fk1 FOREIGN KEY(Team_Code) REFERENCES TEAM(Team_Code),
	CONSTRAINT DTREC_fk2 FOREIGN KEY(Doc_ID) REFERENCES JuniorDR(Doc_ID)
);




CREATE TABLE PERFORMANCE
(
	SerPerf_NO int,
	Doc_ID char(8),
	Team_Code char(8),
	DATE_GRADE varchar(3),
	perf_description varchar(60),
	fromDate date,
	toDate date,
	estab varchar(60),
	newPosition varchar(30),
	constraint perf_pk PRIMARY KEY(SerPerf_No,Doc_ID,Team_code),
	CONSTRAINT perf_fk1 FOREIGN KEY(Doc_ID) REFERENCES JuniorDR(Doc_ID),
	CONSTRAINT perf_fk2 FOREIGN KEY(Team_Code) REFERENCES TEAM(Team_Code)
);


-------------------------------------------------------------------
-------------------------------------------------------------------
-------------- INSERTION QUERIES FOR THE TABLES -------------------
-------------------------------------------------------------------

-------------------------------------------------------------------
-- insertion quereies of  SPECIALITY Table

INSERT INTO [Speciality]
           ([Spec_Code]
           ,[Name]
           ,[levelof])
     VALUES
           ('009',
           'Brain Hospital',
           9)


INSERT INTO [Speciality]
           ([Spec_Code]
           ,[Name]
           ,[levelof])
     VALUES
           ('010',
           'EYE_Hospital',
           6)



INSERT INTO [Speciality]
           ([Spec_Code]
           ,[Name]
           ,[levelof])
     VALUES
           ('011',
           'Lungs Hospital',
           5)


		   INSERT INTO [Speciality]
           ([Spec_Code]
           ,[Name]
           ,[levelof])
     VALUES
           ('012',
           'Brain Hospital',
           1)


		   INSERT INTO [Speciality]
           ([Spec_Code]
           ,[Name]
           ,[levelof])
     VALUES
           ('013',
           'Tumor Hospital',
           7)


		   INSERT INTO [Speciality]
           ([Spec_Code]
           ,[Name]
           ,[levelof])
     VALUES
           ('014',
           'Cancer Hospital',
           5)


		   INSERT INTO [Speciality]
           ([Spec_Code]
           ,[Name]
           ,[levelof])
     VALUES
           ('015',
           'Bone Hospital',
           5)

		   select *from Speciality;




----------------------------------------------------------------

-- Consultant table insertion queries

INSERT INTO [Consultant]
           ([Const_ID]
           ,[Name]
           ,[Address]
           ,[Billing_Rate]
           ,[Salary]
           ,[Phone]
           ,[DOB]
           ,[Spec_Code]
           ,[position])
     VALUES
           ('19i-0729',
           'Hamza',
		   'H/No 13',
           1000,
          5000,
         '0311524169',
          '04-06-1989',
           '008',
          'Head')

INSERT INTO [Consultant]
           ([Const_ID]
           ,[Name]
           ,[Address]
           ,[Billing_Rate]
           ,[Salary]
           ,[Phone]
           ,[DOB]
           ,[Spec_Code]
           ,[position])
     VALUES
           ('19i-0484',
           'Hamza Ali',
		   'H/No 14',
           11000,
          4000,
         '0311224169',
          '04-06-1969',
           '009',
          'Chief')

INSERT INTO [Consultant]
           ([Const_ID]
           ,[Name]
           ,[Address]
           ,[Billing_Rate]
           ,[Salary]
           ,[Phone]
           ,[DOB]
           ,[Spec_Code]
           ,[position])
     VALUES
           ('19i-0584',
           'Usama Ali',
		   'H/No 18',
           1400,
          6000,
         '0311724139',
          '11-06-1969',
           '010',
          'CEO')

		  
INSERT INTO [Consultant]
           ([Const_ID]
           ,[Name]
           ,[Address]
           ,[Billing_Rate]
           ,[Salary]
           ,[Phone]
           ,[DOB]
           ,[Spec_Code]
           ,[position])
     VALUES
           ('19i-0000',
           'Saim Ali',
		   'H/No 18',
           2400,
          6000,
         '0311724199',
          '11-06-1969',
           '011',
          'CEO')


		  INSERT INTO [Consultant]
           ([Const_ID]
           ,[Name]
           ,[Address]
           ,[Billing_Rate]
           ,[Salary]
           ,[Phone]
           ,[DOB]
           ,[Spec_Code]
           ,[position])
     VALUES
           ('19i-0001',
           'Ali Raza',
		   'H/No 14',
           2400,
          6000,
         '0333924199',
          '11-06-1969',
           '013',
          'Manager')


		  INSERT INTO [Consultant]
           ([Const_ID]
           ,[Name]
           ,[Address]
           ,[Billing_Rate]
           ,[Salary]
           ,[Phone]
           ,[DOB]
           ,[Spec_Code]
           ,[position])
     VALUES
           ('19i-0002',
           'Saim Ali',
		   'H/No 19',
           2400,
          6000,
         '0311524199',
          '11-06-1969',
           '014',
          'CEO')


		  INSERT INTO [Consultant]
           ([Const_ID]
           ,[Name]
           ,[Address]
           ,[Billing_Rate]
           ,[Salary]
           ,[Phone]
           ,[DOB]
           ,[Spec_Code]
           ,[position])
     VALUES
           ('19i-0003',
           'Zaib Ali',
		   'H/No 118',
           2400,
          6050,
         '0351724199',
          '11-06-1969',
           '015',
          'CEO')

	----------------------------------------------------
-- Ward table insertion queries
--------------------------------------------------------
INSERT INTO [dbo].[WARD]
           ([Ward_ID]
           ,[Name]
           ,[Floor_no]
           ,[Capacity]
           ,[Spec_Code])
     VALUES
           ('B1',
			'Emergency',
           1,
           20,
          '009')


INSERT INTO [dbo].[WARD]
           ([Ward_ID]
           ,[Name]
           ,[Floor_no]
           ,[Capacity]
           ,[Spec_Code])
     VALUES
           ('B2',
			'Delivery',
           2,
           30,
          '008')


INSERT INTO [dbo].[WARD]
           ([Ward_ID]
           ,[Name]
           ,[Floor_no]
           ,[Capacity]
           ,[Spec_Code])
     VALUES
           ('B3',
			'Accident',
           11,
           20,
          '011')


		  INSERT INTO [dbo].[WARD]
           ([Ward_ID]
           ,[Name]
           ,[Floor_no]
           ,[Capacity]
           ,[Spec_Code])
     VALUES
           ('B4',
			'CheckUP',
           11,
           20,
          '013')

		    INSERT INTO [dbo].[WARD]
           ([Ward_ID]
           ,[Name]
           ,[Floor_no]
           ,[Capacity]
           ,[Spec_Code])
     VALUES
           ('B5',
			'Operation',
           11,
           20,
          '014')


		  
		    INSERT INTO [dbo].[WARD]
           ([Ward_ID]
           ,[Name]
           ,[Floor_no]
           ,[Capacity]
           ,[Spec_Code])
     VALUES
           ('B6',
			'Visit',
           11,
           20,
          '015')


---------------------------------------------------------
-- Table insertion queries for complaint
INSERT INTO [Complaint]
           ([COM_CODE]
           ,[TITLE]
           ,[DESCR])
     VALUES
           (1001,
           'Cleaning Issues',
           'Floors are not clean.')


INSERT INTO [Complaint]
           ([COM_CODE]
           ,[TITLE]
           ,[DESCR])
     VALUES
           (1002,
           'Dealing Issue',
           'Not dealt proplerly.')


INSERT INTO [Complaint]
           ([COM_CODE]
           ,[TITLE]
           ,[DESCR])
     VALUES
           (1003,
           'Room Issues',
           'Room was not allocated for patient.')

		   INSERT INTO [Complaint]
           ([COM_CODE]
           ,[TITLE]
           ,[DESCR])
     VALUES
           (1004,
           'Room Issues',
           'Room was not allocated for patient.')

		   INSERT INTO [Complaint]
           ([COM_CODE]
           ,[TITLE]
           ,[DESCR])
     VALUES
           (1005,
           'Phone Issues',
           'Phone was not allocated for patient.')

		   INSERT INTO [Complaint]
           ([COM_CODE]
           ,[TITLE]
           ,[DESCR])
     VALUES
           (1006,
           'WashRoom Issues',
           'WashRoom was not allocated for patient.')

		   INSERT INTO [Complaint]
           ([COM_CODE]
           ,[TITLE]
           ,[DESCR])
     VALUES
           (1007,
           'Room Issues',
           'Room was not allocated for patient.')


-----------------------------------------------------------
-- insertion queries for Treatment
INSERT INTO [TREATMENT]
           ([TRT_CODE]
           ,[NAME]
           ,[DESCR])
     VALUES
           ('0001',
           'Burn Treatment',
           'Patient burned during House fight.')


INSERT INTO [TREATMENT]
           ([TRT_CODE]
           ,[NAME]
           ,[DESCR])
     VALUES
           ('0002',
           'Delivery Treatment',
           'Isntant Operation required.')

INSERT INTO [TREATMENT]
           ([TRT_CODE]
           ,[NAME]
           ,[DESCR])
     VALUES
           ('0003',
           'Accident Treatment',
           'A person fall from motor bike.')


		   INSERT INTO [TREATMENT]
           ([TRT_CODE]
           ,[NAME]
           ,[DESCR])
     VALUES
           ('0004',
           'Accident Treatment',
           'A person fall from motor bike.')


		   INSERT INTO [TREATMENT]
           ([TRT_CODE]
           ,[NAME]
           ,[DESCR])
     VALUES
           ('0005',
           'Accident Treatment',
           'A person fall from motor bike.')

		   INSERT INTO [TREATMENT]
           ([TRT_CODE]
           ,[NAME]
           ,[DESCR])
     VALUES
           ('0006',
           'Accident Treatment',
           'A person fall from motor bike.')

-----------------------------------------------------------
-- Insertion quereise for Pateint Table 
INSERT INTO [dbo].[PATIENT]
           ([PAT_ID]
           ,[NAME]
           ,[ADDRESS]
           ,[Phone]
           ,[City]
           ,[DOB])
     VALUES
           ('0001',
          'Usama',
           'H/No 17',
         '031607645673',
           'Rawalpindi',
        '08-11-2000')


INSERT INTO [dbo].[PATIENT]
           ([PAT_ID]
           ,[NAME]
           ,[ADDRESS]
           ,[Phone]
           ,[City]
           ,[DOB])
     VALUES
           ('0002',
          'Ashar',
           'H/No 18',
         '031637645673',
           'Rawalpindi',
        '11-01-2000')


INSERT INTO [dbo].[PATIENT]
           ([PAT_ID]
           ,[NAME]
           ,[ADDRESS]
           ,[Phone]
           ,[City]
           ,[DOB])
     VALUES
           ('0003',
          'Haider',
           'H/No 21',
         '031637646673',
           'Karachi',
        '11-07-1989')


		INSERT INTO [dbo].[PATIENT]
           ([PAT_ID]
           ,[NAME]
           ,[ADDRESS]
           ,[Phone]
           ,[City]
           ,[DOB])
     VALUES
           ('0004',
          'Haider',
           'H/No 21',
         '031637646663',
           'Karachi',
        '11-07-1989')


		INSERT INTO [dbo].[PATIENT]
           ([PAT_ID]
           ,[NAME]
           ,[ADDRESS]
           ,[Phone]
           ,[City]
           ,[DOB])
     VALUES
           ('0005',
          'Haider',
           'H/No 21',
         '031687646673',
           'Karachi',
        '11-07-1989')


		INSERT INTO [dbo].[PATIENT]
           ([PAT_ID]
           ,[NAME]
           ,[ADDRESS]
           ,[Phone]
           ,[City]
           ,[DOB])
     VALUES
           ('0006',
          'Haider',
           'H/No 21',
         '031637646693',
           'Karachi',
        '11-07-1989')


		INSERT INTO [dbo].[PATIENT]
           ([PAT_ID]
           ,[NAME]
           ,[ADDRESS]
           ,[Phone]
           ,[City]
           ,[DOB])
     VALUES
           ('0007',
          'Haider',
           'H/No 21',
         '031637669673',
           'Karachi',
        '11-07-1989')


------------------------------------------------------------
--insertion quereise for Nure
INSERT INTO [Nurse]
           ([Nurse_ID]
           ,[NAME]
           ,[ADDRESS]
           ,[TELNO]
           ,[DOB]
           ,[NurseType]
           ,[HireDate]
           ,[position])
     VALUES
           ('001',
           'Sadia',
          'H/No 31',
          '03154356787',
           '1990-12-12',
           'Care',
           '2000-11-11',
           'Senior')


INSERT INTO [Nurse]
           ([Nurse_ID]
           ,[NAME]
           ,[ADDRESS]
           ,[TELNO]
           ,[DOB]
           ,[NurseType]
           ,[HireDate]
           ,[position])
     VALUES
           ('002',
           'Nadia',
          'H/No 21',
          '03154756787',
           '1999-05-02',
           'Care',
           '2006-10-11',
           'Junior')


INSERT INTO [Nurse]
           ([Nurse_ID]
           ,[NAME]
           ,[ADDRESS]
           ,[TELNO]
           ,[DOB]
           ,[NurseType]
           ,[HireDate]
           ,[position])
     VALUES
           ('003',
           'Naheed',
          'H/No 26',
          '03151756787',
           '1979-05-02',
           'Care',
           '2016-10-11',
           'Junior')

		   INSERT INTO [Nurse]
           ([Nurse_ID]
           ,[NAME]
           ,[ADDRESS]
           ,[TELNO]
           ,[DOB]
           ,[NurseType]
           ,[HireDate]
           ,[position])
     VALUES
           ('004',
           'Naheed',
          'H/No 26',
          '03351756787',
           '1979-05-02',
           'Care',
           '2016-10-11',
           'Junior')


		    INSERT INTO [Nurse]
           ([Nurse_ID]
           ,[NAME]
           ,[ADDRESS]
           ,[TELNO]
           ,[DOB]
           ,[NurseType]
           ,[HireDate]
           ,[position])
     VALUES
           ('005',
           'Naheed',
          'H/No 26',
          '03351656787',
           '1979-05-02',
           'Care',
           '2016-10-11',
           'Junior')

		    INSERT INTO [Nurse]
           ([Nurse_ID]
           ,[NAME]
           ,[ADDRESS]
           ,[TELNO]
           ,[DOB]
           ,[NurseType]
           ,[HireDate]
           ,[position])
     VALUES
           ('006',
           'Naheed',
          'H/No 26',
          '03151796787',
           '1979-05-02',
           'Care',
           '2016-10-11',
           'Junior')

----------------------------------------------------------
-- insertion quereise in table [NurseShift]
INSERT INTO [NurseShift]
           ([Ser_NS]
           ,[Sis_ID]
           ,[Shift]
           ,[Incharge_ward])
     VALUES
           (1001,
           '001',
           'Day',
           'B1')



INSERT INTO [NurseShift]
           ([Ser_NS]
           ,[Sis_ID]
           ,[Shift]
           ,[Incharge_ward])
     VALUES
           (1002,
           '002',
           'Night',
           'B2')



INSERT INTO [NurseShift]
           ([Ser_NS]
           ,[Sis_ID]
           ,[Shift]
           ,[Incharge_ward])
     VALUES
           (1003,
           '003',
           'Day',
           'B3')

		   INSERT INTO [NurseShift]
           ([Ser_NS]
           ,[Sis_ID]
           ,[Shift]
           ,[Incharge_ward])
     VALUES
           (1004,
           '004',
           'Day',
           'B4')

		     INSERT INTO [NurseShift]
           ([Ser_NS]
           ,[Sis_ID]
           ,[Shift]
           ,[Incharge_ward])
     VALUES
           (1005,
           '005',
           'Day',
           'B5')


		     INSERT INTO [NurseShift]
           ([Ser_NS]
           ,[Sis_ID]
           ,[Shift]
           ,[Incharge_ward])
     VALUES
           (1006,
           '006',
           'Day',
           'B6')

--------------------------------------------------------------
----- insert quere for table [RegNurse]
INSERT INTO [RegNurse]
           ([RNurse_Id]
           ,[SAL]
           ,[bonus]
           ,[pension])
     VALUES
           ('001',
			5000,
           1000,
           3000)

INSERT INTO [RegNurse]
           ([RNurse_Id]
           ,[SAL]
           ,[bonus]
           ,[pension])
     VALUES
           ('002',
			6500,
           1100,
           3200)

INSERT INTO [RegNurse]
           ([RNurse_Id]
           ,[SAL]
           ,[bonus]
           ,[pension])
     VALUES
           ('003',
			7800,
           2100,
           3900)


		   INSERT INTO [RegNurse]
           ([RNurse_Id]
           ,[SAL]
           ,[bonus]
           ,[pension])
     VALUES
           ('004',
			7800,
           2100,
           3900)

		   INSERT INTO [RegNurse]
           ([RNurse_Id]
           ,[SAL]
           ,[bonus]
           ,[pension])
     VALUES
           ('005',
			7800,
           2100,
           3900)

		   INSERT INTO [RegNurse]
           ([RNurse_Id]
           ,[SAL]
           ,[bonus]
           ,[pension])
     VALUES
           ('006',
			7800,
           2100,
           3900)

		  

---------------------------------------------------------------
-- insertion queries for table [NonRegNurse]

INSERT INTO [dbo].[NonRegNurse]
           ([NRNurse_ID]
           ,[rate]
           ,[workHrs])
     VALUES
           ('001',
            2100,
            5)


INSERT INTO [dbo].[NonRegNurse]
           ([NRNurse_ID]
           ,[rate]
           ,[workHrs])
     VALUES
           ('002',
            2500,
            11)


INSERT INTO [dbo].[NonRegNurse]
           ([NRNurse_ID]
           ,[rate]
           ,[workHrs])
     VALUES
           ('003',
            3500,
            9)

			INSERT INTO [dbo].[NonRegNurse]
           ([NRNurse_ID]
           ,[rate]
           ,[workHrs])
     VALUES
           ('004',
            3500,
            9)

			INSERT INTO [dbo].[NonRegNurse]
           ([NRNurse_ID]
           ,[rate]
           ,[workHrs])
     VALUES
           ('005',
            3500,
            9)


			INSERT INTO [dbo].[NonRegNurse]
           ([NRNurse_ID]
           ,[rate]
           ,[workHrs])
     VALUES
           ('006',
            3500,
            9)

------------------------------------------------------------------------
-- insertion querise for table careunit

INSERT INTO [CAREUNIT]
           ([CU_code]
           ,[ward_ID]
           ,[name]
           ,[capacity]
           ,[Head_Nurse])
     VALUES
           ('001',
			'B1',
           'Special Care Unit',
           120,
           '001')



INSERT INTO [CAREUNIT]
           ([CU_code]
           ,[ward_ID]
           ,[name]
           ,[capacity]
           ,[Head_Nurse])
     VALUES
           ('002',
			'B2',
           'Children Care Unit',
           110,
           '002')


INSERT INTO [CAREUNIT]
           ([CU_code]
           ,[ward_ID]
           ,[name]
           ,[capacity]
           ,[Head_Nurse])
     VALUES
           ('003',
			'B2',
           'Emergency Care Unit',
           210,
           '003')
		   

		   INSERT INTO [CAREUNIT]
           ([CU_code]
           ,[ward_ID]
           ,[name]
           ,[capacity]
           ,[Head_Nurse])
     VALUES
           ('004',
			'B3',
           'Emergency Care Unit',
           210,
           '004')

		    INSERT INTO [CAREUNIT]
           ([CU_code]
           ,[ward_ID]
           ,[name]
           ,[capacity]
           ,[Head_Nurse])
     VALUES
           ('005',
			'B4',
           'Emergency Care Unit',
           210,
           '005')


		      INSERT INTO [CAREUNIT]
           ([CU_code]
           ,[ward_ID]
           ,[name]
           ,[capacity]
           ,[Head_Nurse])
     VALUES
           ('006',
			'B5',
           'Emergency Care Unit',
           210,
           '006')

--------------------------------------------------------------------------------
-- insertion quereis for table BED
INSERT INTO [BED]
           ([BedNo]
           ,[bedtype]
           ,[sizeOfBed]
           ,[CU_Code]
           ,[Ward_No])
     VALUES
           (1001,
          'Normal',
           '6 Foot',
           '001',
	       'B1' )


INSERT INTO [BED]
           ([BedNo]
           ,[bedtype]
           ,[sizeOfBed]
           ,[CU_Code]
           ,[Ward_No])
     VALUES
           (1002,
          'Electric',
           '6 Foot',
           '002',
	       'B2' )



INSERT INTO [BED]
           ([BedNo]
           ,[bedtype]
           ,[sizeOfBed]
           ,[CU_Code]
           ,[Ward_No])
     VALUES
           (1003,
          'Semi-Electric',
           '7 Foot',
           '003',
	       'B3' )


		   INSERT INTO [BED]
           ([BedNo]
           ,[bedtype]
           ,[sizeOfBed]
           ,[CU_Code]
           ,[Ward_No])
     VALUES
           (1004,
          'Semi-Electric',
           '7 Foot',
           '004',
	       'B4' )

		   INSERT INTO [BED]
           ([BedNo]
           ,[bedtype]
           ,[sizeOfBed]
           ,[CU_Code]
           ,[Ward_No])
     VALUES
           (1005,
          'Semi-Electric',
           '7 Foot',
           '005',
	       'B5' )


		     INSERT INTO [BED]
           ([BedNo]
           ,[bedtype]
           ,[sizeOfBed]
           ,[CU_Code]
           ,[Ward_No])
     VALUES
           (1006,
          'Semi-Electric',
           '7 Foot',
           '006',
	       'B6' )


------------------------------------------------------------------------------
--insertion queries for table TEAM
INSERT INTO [TEAM]
           ([Team_Code]
           ,[Name]
           ,[Const_ID])
     VALUES
           ('Team0001',
           'Surgeaons',
			'19i-0484')

INSERT INTO [TEAM]
           ([Team_Code]
           ,[Name]
           ,[Const_ID])
     VALUES
           ('Team0002',
           'MBBS',
			'19i-0729')
			
INSERT INTO [TEAM]
           ([Team_Code]
           ,[Name]
           ,[Const_ID])
     VALUES
           ('Team0003',
           'Neurologists',
			'19i-0584')

			INSERT INTO [TEAM]
           ([Team_Code]
           ,[Name]
           ,[Const_ID])
     VALUES
           ('Team0004',
           'Neurologist',
			'19i-0000')

			INSERT INTO [TEAM]
           ([Team_Code]
           ,[Name]
           ,[Const_ID])
     VALUES
           ('Team0005',
           'Psychatrist',
			'19i-0001')

			INSERT INTO [TEAM]
           ([Team_Code]
           ,[Name]
           ,[Const_ID])
     VALUES
           ('Team0006',
           'Psychatrists',
			'19i-0002')

			INSERT INTO [TEAM]
           ([Team_Code]
           ,[Name]
           ,[Const_ID])
     VALUES
           ('Team0007',
           'Psychatriste',
			'19i-0003')


---------------------------------------------------------------------------------
--insertion queries in table JuniorDR

INSERT INTO [JuniorDR]
           ([Doc_ID]
           ,[Name]
           ,[ADDRESS]
           ,[Salary]
           ,[Phone]
           ,[Positon]
           ,[DOB])
     VALUES
           ('Doc_0001',
           'Salman Haider',
           'H/No 19',
           41000,
           '031467565678',
           'Heart Dept',
          '11-11-1989')


INSERT INTO [JuniorDR]
           ([Doc_ID]
           ,[Name]
           ,[ADDRESS]
           ,[Salary]
           ,[Phone]
           ,[Positon]
           ,[DOB])
     VALUES
           ('Doc_0002',
           'ALi Haider',
           'H/No 21',
           41900,
           '032467565678',
           'Emergency Dept',
          '01-05-1999')

INSERT INTO [JuniorDR]
           ([Doc_ID]
           ,[Name]
           ,[ADDRESS]
           ,[Salary]
           ,[Phone]
           ,[Positon]
           ,[DOB])
     VALUES
           ('Doc_0003',
           'Ali Raza',
           'H/No 59',
           71000,
           '033467565678',
           'Delivery Dept',
          '07-01-1969')


		  INSERT INTO [JuniorDR]
           ([Doc_ID]
           ,[Name]
           ,[ADDRESS]
           ,[Salary]
           ,[Phone]
           ,[Positon]
           ,[DOB])
     VALUES
           ('Doc_0004',
           'Ali Raza',
           'H/No 59',
           71000,
           '033467665678',
           'Delivery Dept',
          '07-01-1969')


		  INSERT INTO [JuniorDR]
           ([Doc_ID]
           ,[Name]
           ,[ADDRESS]
           ,[Salary]
           ,[Phone]
           ,[Positon]
           ,[DOB])
     VALUES
           ('Doc_0005',
           'Ali Raza',
           'H/No 59',
           71000,
           '03346756598',
           'Delivery Dept',
          '07-01-1969')


		  INSERT INTO [JuniorDR]
           ([Doc_ID]
           ,[Name]
           ,[ADDRESS]
           ,[Salary]
           ,[Phone]
           ,[Positon]
           ,[DOB])
     VALUES
           ('Doc_0006',
           'Ali Raza',
           'H/No 59',
           71000,
           '033467565679',
           'Delivery Dept',
          '07-01-1969')

--------------------------------------------------------------------------------
-- insertion quereies for table [NursePreHistory]
INSERT INTO [NursePreHistory]
           ([Ser_NPH]
           ,[Nurse_ID]
           ,[JoinDate]
           ,[CU_Code]
           ,[Ward_id])
     VALUES
           (2001,
           '001',
           '09-07-2001',
           '001',
			'B1')


INSERT INTO [NursePreHistory]
           ([Ser_NPH]
           ,[Nurse_ID]
           ,[JoinDate]
           ,[CU_Code]
           ,[Ward_id])
     VALUES
           (2002,
           '002',
           '09-07-2006',
           '002',
			'B2')


INSERT INTO [NursePreHistory]
           ([Ser_NPH]
           ,[Nurse_ID]
           ,[JoinDate]
           ,[CU_Code]
           ,[Ward_id])
     VALUES
           (2003,
           '002',
           '09-07-1999',
           '003',
			'B3')

			INSERT INTO [NursePreHistory]
           ([Ser_NPH]
           ,[Nurse_ID]
           ,[JoinDate]
           ,[CU_Code]
           ,[Ward_id])
     VALUES
           (2004,
           '003',
           '09-07-1999',
           '004',
			'B4')

				INSERT INTO [NursePreHistory]
           ([Ser_NPH]
           ,[Nurse_ID]
           ,[JoinDate]
           ,[CU_Code]
           ,[Ward_id])
     VALUES
           (2005,
           '004',
           '09-07-1999',
           '005',
			'B5')

				INSERT INTO [NursePreHistory]
           ([Ser_NPH]
           ,[Nurse_ID]
           ,[JoinDate]
           ,[CU_Code]
           ,[Ward_id])
     VALUES
           (2006,
           '005',
           '09-07-1999',
           '006',
			'B6')
----------------------------------------------------------------------------------
-- insertion quereise for table [Pataint_Incharge]
INSERT INTO [Pataint_Incharge]
           ([Ser_PatINC]
           ,[pat_Id]
           ,[Doc_ID]
           ,[Inc_Date])
     VALUES
           (10001,
           '0001    ',
           'Doc_0001',
           '09-07-2005')


INSERT INTO [Pataint_Incharge]
           ([Ser_PatINC]
           ,[pat_Id]
           ,[Doc_ID]
           ,[Inc_Date])
     VALUES
           (10011,
           '0002    ',
           'Doc_0002',
           '09-07-2006')


INSERT INTO [Pataint_Incharge]
           ([Ser_PatINC]
           ,[pat_Id]
           ,[Doc_ID]
           ,[Inc_Date])
     VALUES
           (10006,
           '0003    ',
           'Doc_0003',
           '11-07-2015')

		   INSERT INTO [Pataint_Incharge]
           ([Ser_PatINC]
           ,[pat_Id]
           ,[Doc_ID]
           ,[Inc_Date])
     VALUES
           (10007,
           '0004    ',
           'Doc_0004',
           '11-07-2015')

		   
		   INSERT INTO [Pataint_Incharge]
           ([Ser_PatINC]
           ,[pat_Id]
           ,[Doc_ID]
           ,[Inc_Date])
     VALUES
           (10008,
           '0005    ',
           'Doc_0005',
           '11-07-2015')

		   INSERT INTO [Pataint_Incharge]
           ([Ser_PatINC]
           ,[pat_Id]
           ,[Doc_ID]
           ,[Inc_Date])
     VALUES
           (100015,
           '0006    ',
           'Doc_0006',
           '11-07-2015')

------------------------------------------------------------------------
-- insertion quereies for table Medical_History

INSERT INTO [Medical_Histroy]
           ([Serial_no]
           ,[pat_Id]
           ,[Doc_ID]
           ,[TRT_Code]
           ,[Com_Code]
           ,[Start_Date]
           ,[End_Date])
     VALUES
           (10001,
           '0001',
           'Doc_0001',
           '0001',
           1001,
          '01-01-2010',
           '01-02-2010')



INSERT INTO [Medical_Histroy]
           ([Serial_no]
           ,[pat_Id]
           ,[Doc_ID]
           ,[TRT_Code]
           ,[Com_Code]
           ,[Start_Date]
           ,[End_Date])
     VALUES
           (10002,
           '0002',
           'Doc_0002',
           '0002',
           1002,
          '02-02-2011',
           '02-03-2011')



INSERT INTO [Medical_Histroy]
           ([Serial_no]
           ,[pat_Id]
           ,[Doc_ID]
           ,[TRT_Code]
           ,[Com_Code]
           ,[Start_Date]
           ,[End_Date])
     VALUES
           (10003,
           '0003',
           'Doc_0003',
           '0003',
           1003,
          '01-04-2016',
           '01-05-2016')

select *from Medical_Histroy;
-----------------------------------------------------------------------------------------
-- insertion queries for table [DOCTEAM_REC]
INSERT INTO [DOCTEAM_REC]
           ([Team_Code]
           ,[Doc_ID]
           ,[joinDate]
           ,[endDate])
     VALUES
           ('Team0001',
           'Doc_0001',
           '07-09-2002',
           '12-11-2015')


INSERT INTO [DOCTEAM_REC]
           ([Team_Code]
           ,[Doc_ID]
           ,[joinDate]
           ,[endDate])
     VALUES
           ('Team0002',
           'Doc_0002',
           '11-09-2012',
           '12-11-2021')


INSERT INTO [DOCTEAM_REC]
           ([Team_Code]
           ,[Doc_ID]
           ,[joinDate]
           ,[endDate])
     VALUES
           ('Team0003',
           'Doc_0003',
           '07-09-2012',
           '12-11-2015')


		   INSERT INTO [DOCTEAM_REC]
           ([Team_Code]
           ,[Doc_ID]
           ,[joinDate]
           ,[endDate])
     VALUES
           ('Team0004',
           'Doc_0004',
           '07-09-2012',
           '12-11-2015')

		   INSERT INTO [DOCTEAM_REC]
           ([Team_Code]
           ,[Doc_ID]
           ,[joinDate]
           ,[endDate])
     VALUES
           ('Team0005',
           'Doc_0005',
           '07-09-2012',
           '12-11-2015')

		    INSERT INTO [DOCTEAM_REC]
           ([Team_Code]
           ,[Doc_ID]
           ,[joinDate]
           ,[endDate])
     VALUES
           ('Team0006',
           'Doc_0006',
           '07-09-2012',
           '12-11-2015')


---------------------------------------------------------------------------------
-- insertion queries for table [PERFORMANCE]

INSERT INTO [PERFORMANCE]
           ([SerPerf_NO]
           ,[Doc_ID]
           ,[Team_Code]
           ,[DATE_GRADE]
           ,[perf_description]
           ,[fromDate]
           ,[toDate]
           ,[estab]
           ,[newPosition])
     VALUES
           (1001,
            'Doc_0001',
           'Team0001',
           'A',
           'Worked Really hard.',
          '11-11-2002',
          '10-08-2010',
          'Showed professionalism.',
           'Specialist')


INSERT INTO [PERFORMANCE]
           ([SerPerf_NO]
           ,[Doc_ID]
           ,[Team_Code]
           ,[DATE_GRADE]
           ,[perf_description]
           ,[fromDate]
           ,[toDate]
           ,[estab]
           ,[newPosition])
     VALUES
           (1002,
            'Doc_0002',
           'Team0002',
           'B+',
           'Delightful in work.',
          '09-11-2012',
          '10-08-2017',
          'Showed professionalism.',
           'Surgeon')


INSERT INTO [PERFORMANCE]
           ([SerPerf_NO]
           ,[Doc_ID]
           ,[Team_Code]
           ,[DATE_GRADE]
           ,[perf_description]
           ,[fromDate]
           ,[toDate]
           ,[estab]
           ,[newPosition])
     VALUES
           (1003,
            'Doc_0003',
           'Team0003',
           'A+',
           'Deliberate to solve rare cases.',
          '05-11-2012',
          '11-08-2015',
          'Showed professionalism.',
           'Neurologist')

select *from [PERFORMANCE];
--------------------------------------------------------------------------------------------

