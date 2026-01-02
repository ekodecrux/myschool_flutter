class ApiConfig {
  // Base URL
  static const String baseUrl = 'https://portal.myschoolct.com/api';
  
  // API Endpoints
  
  // Authentication
  static const String login = '/rest/auth/login';
  static const String register = '/rest/auth/register';
  static const String forgotPassword = '/rest/auth/forgotPassword';
  static const String confirmPassword = '/rest/auth/confirmPassword';
  static const String changePassword = '/rest/auth/changePassword';
  static const String sendOtp = '/rest/auth/sendOtp';
  static const String loginViaOtp = '/rest/auth/loginViaOtp';
  static const String refreshToken = '/rest/auth/refreshToken';
  
  // User Management
  static const String getUserDetails = '/rest/users/getUserDetails';
  static const String updateUserDetails = '/rest/users/updateUserDetails';
  static const String checkCredits = '/rest/users/checkCredits';
  static const String listUsersByRole = '/rest/users/listUsersByRole';
  static const String searchUsers = '/rest/users/search';
  static const String disableAccount = '/rest/users/disableAccount';
  
  // School Management
  static const String createSchool = '/rest/school/create';
  static const String listSchools = '/rest/school/list';
  static const String getSchoolDetails = '/rest/school';
  static const String toggleSchoolStatus = '/toggle-status';
  static const String getActiveSchools = '/rest/school/public/active';
  
  // Image Bank
  static const String fetchImages = '/rest/images/fetch';
  static const String pdfThumbnail = '/rest/images/pdf-thumbnail';
  static const String getMyImages = '/rest/images/myImages/get';
  static const String getFavouriteImages = '/rest/images/myImages/getFavourite';
  static const String saveImage = '/rest/images/myImages/save';
  static const String addToFavourite = '/rest/images/myImages/addToFavourite';
  static const String downloadImage = '/rest/images/download';
  static const String uploadImage = '/rest/images/upload';
  static const String deleteImage = '/rest/images/myImages/delete';
  
  // Search
  static const String globalSearch = '/rest/search/global';
  static const String imageSearch = '/rest/search/images';
  
  // Templates (Makers)
  static const String listTemplates = '/rest/templates/list';
  static const String getTemplate = '/rest/templates';
  static const String saveTemplate = '/rest/templates/save';
  static const String deleteTemplate = '/rest/templates/delete';
  
  // Admin Operations
  static const String getAllUsers = '/rest/admin/users';
  static const String getUserById = '/rest/admin/users';
  static const String updateUserRole = '/rest/admin/users/role';
  static const String addCredits = '/rest/admin/users/credits/add';
  static const String deductCredits = '/rest/admin/users/credits/deduct';
  static const String getSystemStats = '/rest/admin/stats';
  static const String getActivityLogs = '/rest/admin/logs';
  
  // Payments
  static const String createOrder = '/rest/payments/create-order';
  static const String verifyPayment = '/rest/payments/verify';
  static const String getPaymentHistory = '/rest/payments/history';
  static const String getPaymentPlans = '/rest/payments/plans';
  
  // Support
  static const String submitTicket = '/rest/support/ticket';
  static const String getTickets = '/rest/support/tickets';
  static const String getFaq = '/rest/support/faq';
  
  // Timeout configurations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int imagesPerPage = 50;
  
  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String isLoggedInKey = 'is_logged_in';
}
