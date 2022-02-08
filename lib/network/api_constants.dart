//BaseUrl

const String baseUrl = "https://tmba.padc.com.mm";
const String moviePosterBaseUrl = "http://image.tmdb.org/t/p/w400";

//EndPoint
const String registerWithEmailEndPoint = "/api/v1/register";
const String loginWithEmailEndPoint = "/api/v1/email-login";
const String getNowShowingMovieEndPoint = "/api/v1/movies";
const String getMovieDetailsEndPoint = "/api/v1/movies";
const String getCinemasListEndPoint = "/api/v1/cinemas";
const String getCinemaDayTimeSlotEndPoint = "/api/v1/cinema-day-timeslots";
const String getMovieSeatEndPoint = "/api/v1/seat-plan";

//Body in api
const String nameParam = "name";
const String emailParam = "email";
const String phoneParam = "phone";
const String passwordParam = "password";
const String googleAccessTokenParam = "google-access-token";
const String facebookAccessTokenParam = "facebook-access-token";
const String accept = "Accept";
const String applicationJson = "application/json";

//Param Key

const String statusKey = "status";
const String date = "date";
const String cinemaDayTimeSlotId = "cinema_day_timeslot_id";
const String bookingDate = "booking_date";

//Param Value

const String statusValue1 = "current";
const String statusValue2 = "comingsoon";
const String dateValue = "2022-01-27";
const int cinemaDayTimeSlotsIdValue = 1;
const String bookingDateValue = "2-7-2022";

//for test

const String tokenTest = "Bearer 3625|T8kk1yUMpQ1gB1QtKNz2KLJZOm7XYVXpGGKMLa7w";
const String dateTest = "2022-01-31";
