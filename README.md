# LogistaaS Developer Assessment: Author & Book Manager

A Ruby on Rails web application where authors can manage their books. Built as part of the LogistaaS developer assessment.

## Features Included
* **Authentication:** Authors can sign up, log in, and log out (via Devise).
* **Authorization:** Authors can view the global library, but can only edit/delete their own books.
* **Filtering & Search:** Real-time filtering on the Authors and Books index pages (via Filterrific & Turbo Frames).
* **Export:** Download the currently filtered books as a CSV file.
* **Validations:** Unique author names, unique book names, and restricted future release dates.
* **Testing:** Full test suite for models and controllers (via RSpec & FactoryBot).
* **UI:** Styled with Bootstrap 5 and paginated with Pagy.

## Tech Stack
* **Ruby:** 4.0
* **Ruby on Rails:** 8.1
* **Database:** PostgreSQL 18

## Local Setup Instructions

1. **Clone the repository**
   ```bash
   git clone <https://github.com/abdellrahmanHq/book_app>
   cd book_app


2. **Install dependencies**
   ```bash
   bundle install

3. **Create the database**
   ```bash
   rails db:create



4. **Start the Rails server**
   ```bash
   srails s

5. **Open the application**
Visit:
http://localhost:3000