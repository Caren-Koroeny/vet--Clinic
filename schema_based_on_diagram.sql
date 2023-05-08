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

CREATE INDEX ON medical_histories (patient_id);
CREATE INDEX ON medical_histories_has_treatments (medical_history_id);
CREATE INDEX ON medical_histories_has_treatments (treatment_id);
CREATE INDEX ON invoices (medical_history_id);
CREATE INDEX ON invoice_items (treatment_id);
CREATE INDEX ON invoice_items (invoice_id);