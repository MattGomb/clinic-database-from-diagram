CREATE TABLE patients(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255),
  date_of_birth DATE,
  PRIMARY KEY(id)
);

CREATE TABLE medical_histories(
  id INT  GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR(255),
  PRIMARY KEY(id),
  CONSTRAINT fk_patients FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE invoices(
  id INT GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL(10,2),
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  PRIMARY KEY(id),
  CONSTRAINT fk_medical_history FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items(
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL(10,2),
  quantity INT,
  total_price DECIMAl(10,2),
  invoice_id INT,
  treatment_id INT,
  PRIMARY KEY(id),
  CONSTRAINT fk_invoice FOREIGN KEY (invoice_id) REFERENCES invoices(id)
);

CREATE TABLE treatments(
  id INT GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(255),
  name VARCHAR(255),
  PRIMARY KEY(id)
);

ALTER TABLE invoice_items ADD CONSTRAINT fk_treatments FOREIGN KEY (treatment_id) REFERENCES treatments(id);

CREATE TABLE treatments_histories(
  medical_history_id INT,
  treatment_id INT,
  PRIMARY KEY(medical_history_id, treatment_id),
  CONSTRAINT fk_medical_history FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
  CONSTRAINT fk_treatment FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE INDEX patient_id_asc ON medical_histories(patient_id ASC);
CREATE INDEX medical_id_asc ON invoices(medical_history_id ASC);
CREATE INDEX invoice_id_asc ON invoice_items(invoice_id ASC);
CREATE INDEX medical_history_asc ON treatments_histories(medical_history_id ASC);
CREATE INDEX treatment_asc ON treatments_histories(treatment_id ASC);
