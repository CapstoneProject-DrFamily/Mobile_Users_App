class APIHelper {
  //Uri and Prefix API
  static const String URI_PREFIX_API = "capstoneapi-dev.azurewebsites.net";
  static const String PREFIX_API = "https://capstoneapi-dev.azurewebsites.net";

  //API Login
  static const String LOGIN_API = '$PREFIX_API/api/v1/Auth/OTP';

  //API Profile
  static const String GET_PROFILE_BY_ID_API = '$PREFIX_API/api/v1/Profiles/';
  static const String CREATE_PROFILE_API = '$PREFIX_API/api/v1/Profiles';
  static const String UPDATE_PROFILE_API = '$PREFIX_API/api/v1/Profiles';

  //API User
  static const String UPDATE_USER_API = '$PREFIX_API/api/v1/Users';

  //API Patient
  static const String PATIENT_API = '$PREFIX_API/api/v1/Patients';
  static const String CREATE_PATIENT_API = '$PREFIX_API/api/v1/Patients';
  static const String GET_PATIENT_BY_ID_API = '$PREFIX_API/api/v1/Patients/';
  static const String UPDATE_PATIENT_API = '$PREFIX_API/api/v1/Patients';
  static const String GET_DEPENDENT_API = '$PREFIX_API/api/v1/Patients/';
  static const String DELETE_DEPENDENT_API = '$PREFIX_API/api/v1/Patients/';

  //API Symptom
  static const String SYMPTOM_API = '$PREFIX_API/api/v1/Symptoms';

  //API Specialty
  static const String SPECIALTY_API = '$PREFIX_API/api/v1/Specialties';

  //API Health Record
  static const String CREATE_HEALTHRECORD_API =
      '$PREFIX_API/api/v1/HealthRecords';
  static const String GET_HEALTHRECORD_BY_ID_API =
      '$PREFIX_API/api/v1/HealthRecords/';
  static const String UPDATE_HEALTHRECORD_API =
      '$PREFIX_API/api/v1/HealthRecords';

  //API Transaction
  static const String TRANSACTION_API = '$PREFIX_API/api/v1/Transactions';
  static const String TRANSACTION_PATIENT_API =
      '$PREFIX_API/api/v1/Transactions/patients/';
  static const String GET_TRANSACTION_BY_ID_API =
      '$PREFIX_API/api/v1/Transactions/';

  //API Prescription
  static const String PRESCRIPTION_API = '$PREFIX_API/api/v1/Presciptions';

  //API Feedback
  static const String FEEDBACK_API = '$PREFIX_API/api/v1/Feedbacks';

  //API Schedule
  static const String SCHEDULE_API = '$PREFIX_API/api/v1/Schedules';

  //API Convert Currency
  static const String CONVERT_CURR_API =
      'https://openexchangerates.org/api/latest.json?app_id=6b8fe57526b7441d8478b3cedbacac46';

  // static const String CONVERT_CURR_API =
  //     'https://free.currconv.com/api/v7/convert?q=USD_VND&compact=ultra&apiKey=31e1bd042b52358dde02';
}
