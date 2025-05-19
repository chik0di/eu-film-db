<h1 align="center">Database Design and Implementation for Movie Production Companies in Europe</h1>


<p align="center">
  <img src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExbGR2d3ZlYjc3cWxtaWE0NnNleDlnMG9xaGx4aXN6bHR3bHo2a2swMCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/kxKdMAZO0N99S/giphy.gif" width="360" alt="Action" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExd3Jsa2s3amJsdXdjeTQyYjk2ejJvNWdpdGF2dm1zbDQwMWl6dmczdiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Em9cyu8HJBmFSWCRPy/giphy.gif" width="380" alt="film production" />
  &nbsp;&nbsp;&nbsp;
</p>

The movie_production_companies database is a comprehensive MySQL-based system designed to manage data related to movie production companies across Europe. It serves as a tool for educational purposes, showcasing how entities such as companies, films, employees, shareholders, and financial grants can be efficiently organized and analyzed within the film industry. This project was developed to support research through machine learning and data analytics, providing insights into the industry, including trends on funding and the establishment of new production companies. The database follows strict normalization rules (up to Third Normal Form) to eliminate redundancy and ensure data integrity.

[![VIEW PROJECT DOCUMENTATION](https://img.shields.io/badge/VIEW%20PROJECT%20DOCUMENTATION-blue?style=for-the-badge&logo=readthedocs&logoColor=white)](https://sites.google.com/view/eu-film-db)


<h1 align="center">Tools & Technologies </h1> 

<p align="center">
  <img src="https://img.icons8.com/plasticine/100/google-sheets.png" width="100" alt="Google Sheets" />
  &nbsp;&nbsp;
  <a href="https://github.com/chik0di/eu-film-db/blob/master/DDL.sql" target="_blank" rel="noopener">
    <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/mysql/mysql-original-wordmark.svg" width="100" alt="MySQL" />
  </a>
  &nbsp;&nbsp;
  <img src="https://img.icons8.com/color-glass/48/microsoft-access-2019.png" width="100" alt="Microsoft Access" />
  &nbsp;&nbsp;
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/python/python-original.svg" width="100" alt="Python" />
  &nbsp;&nbsp;
  <a href="https://app.powerbi.com/view?r=eyJrIjoiOTAxZjBiZDUtZDE1ZC00YzU2LWExODctOTU2MjFhM2ZiY2YyIiwidCI6IjFmZWExNGY1LTNjYjYtNGM1OC1hYjJiLWY4MGU3ZjQ1OWVkMSIsImMiOjh9" target="_blank" rel="noopener">
    <img width="100" src="https://img.icons8.com/fluency/48/power-bi-2021.png" alt="power-bi-2021"/>
  </a>
</p>




<h1 align="center">Objectives </h1> 

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


[![READ FULL PROJECT OBJECTIVES](https://img.shields.io/badge/READ%20FULL%20PROJECT%20OBJECTIVES-brown?style=for-the-badge&logo=storyblok&logoColor=white)](https://sites.google.com/view/eu-film-db/application-scenario?authuser=0)


#### Next Steps:
- Complete the database.
- Finalize Power BI dashboards and integrate real-time reporting features.


[![INTERACT WITH DATABASE](https://img.shields.io/badge/INTERACT%20WITH%20DATABASE-gold?style=for-the-badge&logo=database&logoColor=white)](https://app.powerbi.com/view?r=eyJrIjoiOTAxZjBiZDUtZDE1ZC00YzU2LWExODctOTU2MjFhM2ZiY2YyIiwidCI6IjFmZWExNGY1LTNjYjYtNGM1OC1hYjJiLWY4MGU3ZjQ1OWVkMSIsImMiOjh9)

## Credits 

[![Gist File](https://img.shields.io/badge/stevewithington-country%20and%20continent%20codes%20list.csv-brightgreen?style=for-the-badge&logo=github&logoColor=white)](https://gist.github.com/stevewithington/20a69c0b6d2ff846ea5d35e5fc47f26c)

[![Powered by Faker](https://img.shields.io/badge/Dummy%20Data-Faker-blueviolet?style=for-the-badge&logo=python&logoColor=white)](https://faker.readthedocs.io/)

[![Diagrams by Lucidchart](https://img.shields.io/badge/Conceptual%20ERD%20Design-Lucidchart-orange?style=for-the-badge&logo=lucidchart&logoColor=white)](https://www.lucidchart.com/)

[![GIFs from GIPHY](https://img.shields.io/badge/GIFs-GIPHY-purple?style=for-the-badge&logo=giphy&logoColor=white)](https://giphy.com/)

[![Badges by Shields.io](https://img.shields.io/badge/Badges-Shields.io-yellow?style=for-the-badge&logo=shieldsdotio)](https://shields.io/)

<p align="left">
  <img src="https://img.shields.io/badge/Icons%20by:-grey?style=for-the-badge" />
  <a href="https://devicon.dev/">
    <img src="https://img.shields.io/badge/Devicon-blue?style=for-the-badge&logo=devicon&logoColor=white" />
  </a>
  <a href="https://icons8.com/">
    <img src="https://img.shields.io/badge/Icons8-brown?style=for-the-badge" />
  </a>
</p>
