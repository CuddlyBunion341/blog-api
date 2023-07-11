# MyBlog API

MyBlog API is the backend component of the MyBlog application, built using Ruby on Rails. It provides the necessary functionality for handling data storage, retrieval, and business logic for the blogging application.

## Features

The MyBlog API includes the following features:

- [ ] User registration and authentication: Provides endpoints for user registration, login, and authentication to secure the API.
- [X] Blog post management: Allows creating, retrieving, updating, and deleting blog posts.
- [ ] Comment system: Enables users to add, retrieve, and manage comments on blog posts.
- [ ] Tag and category management: Supports tagging blog posts with relevant tags and categorizing them into different categories.
- [ ] Search functionality: Provides a search endpoint to search for specific blog posts or topics.
- [ ] User profile management: Includes endpoints for retrieving user profiles and their published blog posts.

## Getting Started

To set up the MyBlog API project locally, follow these steps:

1. **Clone the repository:**
`git clone https://github.com/CuddlyBunion341/blog-api.git`

2. **Install dependencies:**
- bundle install

3. **Database setup:**
- Configure the database settings in the `config/database.yml` file according to your local environment.
- Create the database:
  ```
  rails db:create
  ```
- Run the database migrations:
  ```
  rails db:migrate
  ```

1. **Start the server:**
rails server


The API will be accessible at `http://localhost:3000`.

## API Documentation

The MyBlog API is RESTful and follows standard conventions for resource endpoints and HTTP methods. Detailed documentation for the API endpoints and request/response formats is pending...

## Contributing

Contributions to the MyBlog API are welcome! If you would like to contribute, please follow these guidelines:
- Fork the repository and create a new branch for your feature/bug fix.
- Ensure your code follows the established coding style and conventions.
- Write tests for any new functionality and ensure all tests pass.
- Submit a pull request describing your changes and their purpose.

## License

The MyBlog API is open-source and released under the [MIT License](LICENSE).
