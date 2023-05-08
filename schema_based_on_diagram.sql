CREATE TABLE patients(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories(
	id SERIAL PRIMARY KEY, 
	admitted_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
	patient_id int NOT NULL, 
	status varchar(50), 
	CONSTRAINT fk_patient_medical_histories 
	FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments(
id SERIAL PRIMARY KEY,
type varchar(50),
name varchar(50)
); 

CREATE TABLE medical_histories_has_treatments (
    medical_history_id int references medical_histories(id),
    treatment_id int references treatments(id),
    );

CREATE TABLE invoices(
id SERIAL PRIMARY KEY, 
total_amount decimal, 
generated_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
payed_at  TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, 
medical_history_id int, 
CONSTRAINT fk_invoice_medical FOREIGN KEY (medical_history_id)
	REFERENCES medical_histories(id)
);