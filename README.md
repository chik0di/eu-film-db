## Database Design and Implementation for Movie Production Companies in Europe

![Film Production](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExbGR2d3ZlYjc3cWxtaWE0NnNleDlnMG9xaGx4aXN6bHR3bHo2a2swMCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/kxKdMAZO0N99S/giphy.gif) [Action](https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExd3Jsa2s3amJsdXdjeTQyYjk2ejJvNWdpdGF2dm1zbDQwMWl6dmczdiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Em9cyu8HJBmFSWCRPy/giphy.gif)
 
## Overview 
The movie_production_companies database is a comprehensive MySQL-based system designed to manage data related to movie production companies across Europe. It serves as a tool for educational purposes, showcasing how entities such as companies, films, employees, shareholders, and financial grants can be efficiently organized and analyzed within the film industry. This project was developed to support research through machine learning and data analytics, providing insights into the industry, including trends on funding and the establishment of new production companies. The database follows strict normalization rules (up to Third Normal Form) to eliminate redundancy and ensure data integrity.
 
[View Full Documentation](https://sites.google.com/view/eu-film-db)
 
## Tools & Technologies 
- MySQL 
- [Microsoft Power BI](https://app.powerbi.com/view?r=eyJrIjoiOTAxZjBiZDUtZDE1ZC00YzU2LWExODctOTU2MjFhM2ZiY2YyIiwidCI6IjFmZWExNGY1LTNjYjYtNGM1OC1hYjJiLWY4MGU3ZjQ1OWVkMSIsImMiOjh9)
- Microsoft Excel
- Microsoft Access
- Python 

## Objectives

- Develop a database for a research project focused on movie production companies.
- Analyze the status of the movie production industry in Europe, including countries like the UK.

#### Production Company Data:
- Includes name, address, ZIP code, city, nation, type (e.g., non-profit), number of employees, and net value.
- Registers details through local government offices (e.g., Companies House in the UK).
- Shareholder information: place of birth, parent's names, personal phone number, national insurance number, and passport number.
- Registration fee details (e.g., £12 in the UK).

#### Employee Data:
- Affiliated with a single production company.
- Classified as crew or staff based on roles.
- Crew roles: actors, directors, producers, editors, costume designers, etc.
- Staff roles: HR, advertising, and administrative positions.
- Employee details: ID, name, date of birth, start date, phone number(s), and email address.

#### Compensation Details:
- Crew: Hourly wages and performance-based bonuses (daily bonuses for actors, completion bonuses for directors).
- Staff: Monthly salary and designated work hours (e.g., 9 AM–5 PM).
- Staff department and building information documented.

#### Movie Data:
- Unique movie codes, titles, release years, and first release dates.
- Co-production tracking for joint ventures between companies.
- Crew members’ roles and responsibilities documented for each movie.
- Genre data for each movie. A movie can have up to 3 genres. 

#### Funding and Grants Tracking:
- Capture grant details: title, funding organization, maximum value, and proposal deadlines.
- Application status tracking (approved, pending, denied).
- Grants can be awarded to single or multiple companies.

#### Next Steps:
- Complete the database.
- Finalize Power BI dashboards and integrate [real-time reporting](https://app.powerbi.com/view?r=eyJrIjoiOTAxZjBiZDUtZDE1ZC00YzU2LWExODctOTU2MjFhM2ZiY2YyIiwidCI6IjFmZWExNGY1LTNjYjYtNGM1OC1hYjJiLWY4MGU3ZjQ1OWVkMSIsImMiOjh9) features.

### Credits 
 https://gist.github.com/stevewithington/20a69c0b6d2ff846ea5d35e5fc47f26c
