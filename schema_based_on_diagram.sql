/* Database schema_based_on_diagram to keep the structure of entire database. */

CREATE TABLE patients (
    id serial PRIMARY KEY,
    name varchar(255),
    date_of_birth date
);

/* Creating a medical_histories table */
CREATE TABLE medical_histories (
    id serial PRIMARY KEY,
    admitted_at timestamp,
    patient_id int REFERENCES patients(id),
    status varchar(255)
);

CREATE TABLE invoices (
    id serial PRIMARY KEY,
    total_amount decimal,
    generated_at timestamp,
    payed_at timestamp,
    medical_history_id int REFERENCES medical_histories(id)
);

CREATE TABLE treatment (
    medical_history_id int PRIMARY KEY REFERENCES medical_histories(id),
    type varchar(255),
    name varchar(255)
);
/*
CREATE TABLE invoice_items (
    id serial PRIMARY KEY,
    unit_price decimal,
    quantity int,
    total_price decimal,
    invoice_id int REFERENCES invoices(id),
    treatment_id int REFERENCES treatment(medical_history_id) -- Corrected reference to medical_history_id
);
*/