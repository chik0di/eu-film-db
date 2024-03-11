''' Due to shortage of hands to manually fill out the Microsoft Access Forms dedicated to Data Entry, the database was programmatically populated via the Faker library. Here's how...
Firstly, we'll establish a connection to movie_production_companies database in MySQL via configparser and pymysql library
'''
import pymysql
import configparser
import random
from faker import Faker
import re

fake = Faker()


def get_connection():
    """Establishes and returns a database connection using pymysql."""
    # Loading database configuration from a config.ini file
    config_parser = configparser.ConfigParser()
    config_parser.read('config.ini')
    
    # Database connection configuration
    config = {
        'host': config_parser.get('database', 'host'),
        'user': config_parser.get('database', 'user'),
        'password': config_parser.get('database', 'password'),
        'database': config_parser.get('database', 'schema'),
        'charset': 'utf8mb4',
        'cursorclass': pymysql.cursors.DictCursor  # Using DictCursor to work with dictionaries
    }
    
    # Attempting to establish a database connection
    try:
        connection = pymysql.connect(**config)
        print("Connection successful")
        return connection
    except Exception as e:
        print(f"Error connecting to the database: {e}")
        return None

''' Now the get_connection function is defined, I proceeded to populating the database starting from the company table. Here's how...'''

def generate_movie_production_company_name():
    # Custom company name patterns for movie production
    patterns = [
        'Studio', 'Films', 'Productions', 'Pictures', 'Cinema', 'Entertainment', 'Entertainment Group'
    ]
    return f"{fake.company()} {random.choice(patterns)}"

def generate_address():
    full_address = fake.address()

    # Removing newline characters to avoid splitting the address across multiple lines
    full_address_single_line = full_address.replace('\n', ', ')

    # Splitting the modified address at the first comma and take the first part
    address_first_part = full_address_single_line.split(',', 1)[0]

    return address_first_part    

def generate_company_data(num_records):
    connection = get_connection()
    try:
        with connection.cursor() as cursor:
            # Fetch city IDs
            cursor.execute("SELECT id FROM city")
            city_ids = [row['id'] for row in cursor.fetchall()]
            
            # Fetch kind_of_organization IDs
            cursor.execute("SELECT id FROM kind_of_organization")
            organization_ids = [row['id'] for row in cursor.fetchall()]
            
            for _ in range(num_records):
                name = generate_movie_production_company_name()
                address = generate_address()
                zip_code = fake.postcode()
                city_id = fake.random.choice(city_ids)

                # country_code are set by triggers based on city_id  and registration_body_id are set by triggers based on country_code

                kind_of_organization_id = fake.random.choice(organization_ids)

                # ensuring the total liability is one digit lesser than the total asset, so as not to encounter negative net values 
                asset_digit = fake.random_int(min=6, max=8) 
                total_asset = round(fake.random_number(digits=asset_digit), 2)
                total_liability = round(fake.random_number(digits=asset_digit-1), 2)

                registration_date = fake.date_between(start_date='-15y', end_date='today')
                
                sql = """
                INSERT INTO company (name, address, zip_code, city_id, kind_of_organization_id, total_asset, total_liability, registration_date)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """
                cursor.execute(sql, (name, address, zip_code, city_id, kind_of_organization_id, total_asset, total_liability, registration_date))
            
            connection.commit()
            print(f"{num_records} companies inserted.")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        connection.close()


generate_company_data(30)

'''Next, the _shareholder_ table.'''

def generate_phone_number():
    # Using numerify to ensure consistent format
    phone_number = fake.numerify(text='(###) ###-###-####')
    return phone_number

def insert_shareholders(num_records):
    connection = get_connection()
    if connection is None:
        print("Failed to connect to database. Exiting...")
        return

    try:
        with connection.cursor() as cursor:
            # Fetch company IDs and country codes from the database
            cursor.execute("SELECT id FROM company")
            company_ids = [row['id'] for row in cursor.fetchall()]

            cursor.execute("SELECT code FROM country")
            country_codes = [row['code'] for row in cursor.fetchall()]

            for _ in range(num_records):
                # Generate fake data for each field in the shareholder table
                first_name = fake.first_name()
                last_name = fake.last_name()
                company_id = random.choice(company_ids)  # Randomly choose a company ID
                country_code = random.choice(country_codes)  # Randomly choose a country code
                place_of_birth = fake.city()
                mothers_maiden_name = fake.last_name_female()
                fathers_first_name = fake.first_name_male()
                personal_telephone = generate_phone_number()
                national_insurance_number = fake.ssn()  # Assuming SSN can serve as an insurance number
                passport_number = fake.bothify(text='??######', letters='ABCDEFGHIJKLMNOPQRSTUVWXYZ')  # Generate a fake passport number
                
                # SQL command to insert a new shareholder
                sql = """
                INSERT INTO shareholder (first_name, last_name, company_id, country_code, place_of_birth, mothers_maiden_name, fathers_first_name, personal_telephone, national_insurance_number, passport_number)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """
                cursor.execute(sql, (first_name, last_name, company_id, country_code, place_of_birth, mothers_maiden_name, fathers_first_name, personal_telephone, national_insurance_number, passport_number))

            # Commit the transaction
            connection.commit()
            print(f"{num_records} shareholders inserted successfully.")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        connection.close()


insert_shareholders(850)

'''Next, the _grant request_ table.'''

def insert_grant_requests(num_records):
    connection = get_connection()
    if connection is None:
        print("Failed to connect to database. Exiting...")
        return

    try:
        with connection.cursor() as cursor:
            for _ in range(num_records):
                # Generate a title for the grant request
                title = fake.catch_phrase()
                
                # Customized funding organization names
                funding_organizations = [
                    'Foundation', 'Council', 'Federation', 'Institute', 'Endowment', 'Fund', 'Trust'
                ]
                funding_organization = f"{fake.company()} {random.choice(funding_organizations)}"
                
                # Generate monetary values and dates
                maximum_monetary_value = round(random.uniform(10000, 100000), 2)
                desired_amount = round(maximum_monetary_value * random.uniform(0.5, 0.9), 2)
                application_date = fake.date_between(start_date="-2y", end_date="today")
                deadline = fake.date_between(start_date="today", end_date="+1y")
                status = random.choice(['Approved', 'Denied', 'Pending'])

                # SQL command to INSERT data
                sql = """
                INSERT INTO grant_request (title, funding_organization, maximum_monetary_value, desired_amount, application_date, deadline, status)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
                """
                cursor.execute(sql, (title, funding_organization, maximum_monetary_value, desired_amount, application_date, deadline, status))

            # Commit the transaction
            connection.commit()
            print(f"{num_records} grant requests inserted successfully.")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        connection.close()

insert_grant_requests(500)

'''Next, the _company grant_ table. The junction table that establishes a many-to-many relationship between the company and the grant_request tables'''

def insert_company_grants(max_grants_per_company=10, max_companies_per_grant=5):
    connection = get_connection()
    if connection is None:
        print("Failed to connect to database. Exiting...")
        return

    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT id FROM company")
            company_ids = [row['id'] for row in cursor.fetchall()]

            cursor.execute("SELECT id FROM grant_request")
            grant_ids = [row['id'] for row in cursor.fetchall()]

            # Track the number of companies assigned to each grant
            grant_companies_count = {grant_id: 0 for grant_id in grant_ids}
            # Keep track of company-grant pairs to avoid duplicates
            company_grant_pairs = set()

            for company_id in company_ids:
                # Randomly determine the number of grants for this company
                num_grants = random.randint(0, max_grants_per_company)
                assigned_grants = 0

                while assigned_grants < num_grants:
                    grant_id = random.choice(grant_ids)

                    # Check if this grant can have more companies and if the pair is unique
                    if grant_companies_count[grant_id] < max_companies_per_grant and (company_id, grant_id) not in company_grant_pairs:
                        sql = "INSERT INTO company_grant (company_id, grant_id) VALUES (%s, %s)"
                        cursor.execute(sql, (company_id, grant_id))
                        company_grant_pairs.add((company_id, grant_id))
                        grant_companies_count[grant_id] += 1
                        assigned_grants += 1

            connection.commit()
            print(f"All grants accounted for and company grants inserted successfully.")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        connection.close()


insert_company_grants()

'''Next, the film table'''

def split_camel_case(color_name):
    spaced_color_name = ' '.join(re.findall(r'[A-Z](?:[a-z]+|[A-Z]*(?=[A-Z]|$))', color_name))
    return spaced_color_name

unique_titles = set()

def generate_movie_title(unique_titles):
    while True:
        title_prefixes = ['The Return of', 'Revenge of', 'Rise of', 'The Fall of', 'The Chronicles of', 'Escape from', 'Battle for', 'Attack of']
        title_suffixes = [': The Last Key', ': A New Hope', ': The Secret Service', ': The Golden Age', ': Endgame', ': Infinity War', ': Dark Fate']
        
        prefix = ["{city}"] 
        suffix = ["{century}", "{year}"]

        # Corrected patterns to include placeholders for Python's str.format
        patterns = [
            "{color_name} {month}", 
            "{noun} of {country}",
            "{adjective} {city}",
            "{first_name}, the {century}",
            "{first_name} {last_name}: {noun} of {city}",
            "How to be a {job} in {country}",
            "{century}:Shades of {color_name}",
            "{color_name} {noun} in {city}",
            "{first_name} and the {adjective} {noun}",
            "The {last_name} Legacy",
            "The {country} Conspiracy",
            "{year} in {country}", "{month} {year} in {country}",
            "{city}'s {noun}",
            # "{noun}", "{year}", "{century}", "{time}", "{color_name}", "{country}",
            "From {country} with {noun}",
            "{century}: The {noun}",
            "Every {month} in {city}",
            "The {adjective} of {noun}",
            "{first_name_male} and {first_name_female}",
            "{noun}: A {city} Story",
            "The {adjective} {noun}",
            "{century}: Rise of {country}",
            "{city}: Age of {color_name}",
            "Tales of {city}",
            "{time} in {city}",
            random.choice(title_prefixes) + " " + random.choice(prefix),
            random.choice(suffix) + random.choice(title_suffixes),
            ]

        # Randomly select a pattern
        pattern = random.choice(patterns)

        # Generate a title based on the selected pattern
        title = pattern.format(
            color_name = split_camel_case(fake.color_name()),
            country = fake.country(),
            city = fake.city(),
            noun = fake.word().capitalize(),
            adjective = fake.word().capitalize(),
            first_name = fake.first_name(),
            first_name_male = fake.first_name_male(),
            first_name_female = fake.first_name_female(),
            last_name = fake.last_name(),
            job = fake.job().split(',')[0],
            century = fake.century(),
            time = fake.time(pattern='%H:%M'),
            month = fake.month_name(),
            year = fake.year()
        )
        if title not in unique_titles:
            unique_titles.add(title)
            return title


def generate_and_insert_films(num_records):
    connection = get_connection()
    if connection is None:
        print("Failed to connect to database. Exiting...")
        return

    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT id FROM company")
            company_ids = [row['id'] for row in cursor.fetchall()]

            for _ in range(num_records):
                title = generate_movie_title(unique_titles)
                company_id = random.choice(company_ids)
                release_year = fake.year()

                # Ensure first_released date falls within the release_year
                start_date = datetime.strptime(f"{release_year}-01-01", "%Y-%m-%d")
                end_date = datetime.strptime(f"{release_year}-12-31", "%Y-%m-%d")
                first_released = fake.date_between_dates(date_start=start_date, date_end=end_date).strftime("%Y-%m-%d")

                sql = "INSERT INTO film (title, company_id, release_year, first_released) VALUES (%s, %s, %s, %s)"
                cursor.execute(sql, (title, company_id, release_year, first_released))

            connection.commit()
            print(f"{num_records} films inserted successfully.")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        connection.close()

generate_and_insert_films(2500)


'''Time to generate the dummy Employees in the _employee_ table.'''


def insert_employees_and_related_data(num_employees_per_company):
    connection = get_connection()
    if connection is None:
        print("Failed to connect to database. Exiting...")
        return

    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT id FROM company")
            companies = [company['id'] for company in cursor.fetchall()]

            cursor.execute("SELECT id, name FROM role")
            roles = [role['name'] for role in cursor.fetchall()]
            cursor.execute("SELECT id, name FROM department")
            departments = [department['name'] for department in cursor.fetchall()]

            
            for company_id in companies:
                for _ in range(num_employees_per_company):
                    gender = random.choice(['male', 'female'])
                    first_name = fake.first_name_male() if gender == 'male' else fake.first_name_female()
                    middle_name = fake.first_name_male() if gender == 'male' else fake.first_name_female()
                    last_name = fake.last_name()
                    date_of_birth = fake.date_of_birth(minimum_age=18, maximum_age=65).strftime('%Y-%m-%d')
                    date_started = fake.date_between(start_date='-5y', end_date='today').strftime('%Y-%m-%d')

                    # Assign a role or department randomly
                    employee_role = random.choice(roles + departments)

                    gender = 'M' if gender == 'male' else 'F'

                    sql_employee = """
                    INSERT INTO employee (company_id, first_name, middle_name, last_name, gender, date_of_birth, date_started, employee_role) 
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                    """
                    cursor.execute(sql_employee, (company_id, first_name, middle_name, last_name, gender, date_of_birth, date_started, employee_role))
                 
                       
            connection.commit()
            print(f"Inserted employees into all {len(companies)} companies.")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        if connection:
            connection.close()

insert_employees_and_related_data(1) 

'''Next, the _phone number_ table'''

def insert_phone_numbers():
    connection = get_connection()
    if connection is None:
        print("Failed to connect to database. Exiting...")
        return
    
    try:
        with connection.cursor() as cursor:
            # Fetch all employee_id
            cursor.execute("SELECT id FROM employee")
            employee_ids = [row['id'] for row in cursor.fetchall()]

            phone_description = ['Mobile', 'Work', 'Emergency']
                        
            for employee_id in employee_ids:

                picker = random.randint(1, len(phone_description))
                descriptions = random.sample(phone_description, picker)
                for description in descriptions:

                    # phone number table id is auto incremented
                    # employee phone number is auto generated with a db logic
                    # phone description is only what must be selected for each employee
                    
                    # Insert data into phone_number table
                    sql = """
                    INSERT INTO phone_number (employee_id, description) 
                    VALUES (%s, %s)
                    """
                    cursor.execute(sql, (employee_id, description))

            connection.commit()
            print("Inserted phone numbers for all employees.")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        connection.close()

insert_phone_numbers()

'''Next, the staff_salary table'''

def insert_staff_salaries():
    connection = get_connection()
    if connection is None:
        print("Failed to connect to database. Exiting...")
        return
    
    try:
        with connection.cursor() as cursor:
            # Fetch all employee_id
            cursor.execute("SELECT id FROM employee")
            employee_ids = [row['id'] for row in cursor.fetchall()]

            working_hours_options = ['Full-time', 'Part-time']
            job_levels = ['Entry', 'Mid', 'Senior', 'Executive']

             # Insert salary if the role belongs to staff
            for employee_id in employee_ids:
                if employee_id.startswith('ST'):
                    working_hours = random.choice(working_hours_options)
                    job_level = random.choice(job_levels)
                    salary = fake.random_number(digits=5) 
                    sql_salary = """
                    INSERT INTO staff_salary (employee_id, working_hours, job_level, salary) VALUES (%s, %s, %s, %s)
                    """
                    cursor.execute(sql_salary, (employee_id, working_hours, job_level, salary))
            connection.commit()
            print("Inserted salaries for all staff members in every company.")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        connection.close()

insert_staff_salaries()

'''The _department address_ table is next to populate'''

def insert_department_addresses():
    connection = get_connection()
    if connection is None:
        print("Failed to connect to database. Exiting...")
        return

    try:
        with connection.cursor() as cursor:
            # Fetch all companies
            cursor.execute("SELECT id FROM company")
            companies = [row['id'] for row in cursor.fetchall()]

            # Fetch all departments
            cursor.execute("SELECT id FROM department")
            departments = [row['id'] for row in cursor.fetchall()]

            for company_id in companies:
                for department_id in departments:
                    # Generate fake address data
                    building = fake.street_name()
                    address = fake.street_address()
                    
                    # Insert data into department_address table
                    sql = """
                    INSERT INTO department_address (department_id, company_id, building, address) 
                    VALUES (%s, %s, %s, %s)
                    """
                    cursor.execute(sql, (department_id, company_id, building, address))

            connection.commit()
            print(f"Inserted department addresses for all companies.")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        connection.close()

insert_department_addresses()

'''Lastly, the _crew info_ table'''