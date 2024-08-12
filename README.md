[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/QpCtzJAE)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-718a45dd9cf7e7f842a935f5ebbe5719a5e09af4491e668f4dbf3b35d5cca122.svg)](https://classroom.github.com/online_ide?assignment_repo_id=15112790&assignment_repo_type=AssignmentRepo)

[Design Workbook](https://docs.google.com/document/d/1ssVW9pDwjFNCNY7O599qxDDmV4yG3kydT4lyQdriNGU/edit#heading=h.30mvr6mmd9p3)


## EnableID
![EnableID logo](https://github.com/user-attachments/assets/5d270671-c155-4364-9c8c-b030fbd093b2)
EnableID addresses the problem of undocumented individuals in Malaysia who struggle to access essential services due to a lack of recognized identification. By providing a secure digital identity platform, our solution enables these individuals to store personal identity documents digitally and access aid and services more easily. It also offers NGOs tools for better identification and data management, ensuring they can efficiently deliver support. In summary, this approach is designed to be effective and deployable from day 1without needing immediate government recognition.
## Screenshots
![User Homepage](https://github.com/user-attachments/assets/d23a005d-9881-448a-b7e7-8a58af2e4fdb)
![Edit user particulars](https://github.com/user-attachments/assets/60d2c3c7-0e2e-4d86-b7cb-4a7fdfcc9c95)
![Ngo Homepage](https://github.com/user-attachments/assets/070c222c-3ebc-4500-8fef-927f350dc30d)

## Run Locally

Clone the project

```bash
  git clone https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-2.git
```

Go to the project directory

```bash
  cd 1d-final-project-summer-2024-sds-2024-team-2
```

Install dependencies

```bash
  bundle install 
```

Setup development database
```bash
  rails db:migrate
  rails db:seed 
```

Start the server

```bash
  rails server
```


## Running Tests

Setup test database
```bash
  rails db:test:prepare 
  rails db:seed RAILS_ENV=test
```

To run unit tests in rspec, run the following command

```bash
  bundle exec rspec
```

To run system tests in cucumber, run the following command

```bash
  bundle exec cucumber
```

## Deployment on Google Cloud

Modify the following files, use rails credentials to store sensitive data:

1. `database.yml`
- Edit `database, username, password, host` variables
2. `cloudbuild.yml`
- Edit `_REGION, _SERVICE_NAME, _INSTANCE_NAME, _PROJECT_ID ` variables
3. `config/storage.yml`
- Edit `project_id, private_key_id, private_key, client_email, client_id, bucket ` variables
4. `Dockerfile`
- Edit `SECRET_KEY_BASE` variable

Then to create the Docker image and deploy this project, run

```bash
  gcloud builds submit
```


## Tech Stack

**Client:** Bootstrap, AJAX, Rails

**Server:** Rails

**Database:** PostgreSQL(Production), SQLite3(Local)

**GCP:** Cloud Run, Cloud Bucket

## Acknowledgements

 - [Our mentor Tony Tan for guiding us throughout the project](https://www.gebirah.org/)


