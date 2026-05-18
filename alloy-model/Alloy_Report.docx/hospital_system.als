// =======================
// Basic Types
// =======================

sig Patient {
    pid: one Int,
    name: one String,
    age: one Int
}

sig Doctor {
    did: one Int,
    name: one String,
    specialization: one String
}

sig Appointment {
    patient: one Patient,
    doctor: one Doctor,
    appId: one Int
}

sig Hospital {
    patients: set Patient,
    doctors: set Doctor,
    appointments: set Appointment
}

// =======================
// Constraints (Facts)
// =======================

fact UniquePatients {
    all disj p1, p2: Patient | p1.pid != p2.pid
}

fact UniqueDoctors {
    all disj d1, d2: Doctor | d1.did != d2.did
}

fact ValidAppointments {
    all a: Appointment |
        a.patient in Patient and
        a.doctor in Doctor
}

// A patient can have multiple appointments
fact PatientAppointments {
    all p: Patient |
        some a: Appointment | a.patient = p
}

// A doctor can have multiple appointments
fact DoctorAppointments {
    all d: Doctor |
        some a: Appointment | a.doctor = d
}

// =======================
// Hospital Constraints
// =======================

fact HospitalRules {
    all h: Hospital |
        h.patients in Patient and
        h.doctors in Doctor and
        h.appointments in Appointment
}

// =======================
// Run Commands
// =======================

run {
    some Patient
    some Doctor
    some Appointment
} for 5
