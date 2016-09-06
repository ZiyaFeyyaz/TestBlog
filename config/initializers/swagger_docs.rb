Swagger::Docs::Config.register_apis({
  "0.0" => {
    # controller_base_path: '',
    api_extension_type: :json,
    api_file_path: "public/api/v0/",
    base_path: 'http://localhost:3000',
    clean_directory: false,
    attributes: {
      :info => {
        "title" => "Test Blog Sample App",
        "description" => "Rails API documention with Swagger UI.",
        "termsOfServiceUrl" => "http://example.com/terms/",
        "contact" => "apiteam@wordnik.com",
      }
    }
  }
})
