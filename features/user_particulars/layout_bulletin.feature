Feature: Interactions on the bulletin board
  As an EnableID user,
  I want the bulletin to order event cards in a chronological order and be easily filtered with a search bar
  So that I can easily navigate the use of the Event Cards posted by NGOs.

Background: 
    Given the following bulletin data exists
        | title                                  | date                | location       | description                                      | ngo_name                                       | saved |
        | Gebirah Aid Giveaway                   | 2024-07-01  | Malaysia      | Welfare giveaway event!                          | Gebirah                                       | false |
        | CARE Medical Camp                      | 2024-08-12  | Kuala Lumpur   | Free medical check-up and healthcare advice.     | CARE International                            | false |
        | Amnesty Legal Aid                      | 2024-08-20  | Penang         | Legal assistance for underprivileged communities.| Amnesty International                          | false |
        | Oxfam Food Distribution                | 2024-09-05  | Ipoh           | Providing food supplies to low-income families.  | Oxfam                                         | false |
        | World Vision Education Fair            | 2024-10-03  | Kota Bharu     | Promoting education for children in rural areas. | World Vision                                  | false |
        | Human Rights Awareness Campaign        | 2024-11-07  | Johor Bahru    | Raising awareness about human rights issues.     | Human Rights Watch                            | false |
        | Gebirah Community Clean-up             | 2024-08-30  | Shah Alam      | Community clean-up and recycling drive.          | Gebirah                                       | false |
        | IRC Refugee Support                    | 2024-09-15  | Seremban       | Support services for refugees and asylum seekers.| International Rescue Committee (IRC)           | false |
        | Doctors Without Borders Health Camp    | 2024-10-21  | Kuching        | Medical assistance for underserved communities.  | Doctors Without Borders/Médecins Sans Frontières | false |
        | NRC Shelter Building                   | 2024-11-14  | Alor Setar     | Building shelters for homeless families.         | Norwegian Refugee Council (NRC)               | false |
        | Save the Children School Supplies Drive| 2024-08-28  | Melaka         | Collecting school supplies for children in need. | Save the Children                             | false |
        | UNHCR Asylum Support                   | 2024-09-12  | Miri           | Providing support for asylum seekers.            | UNHCR                                         | false |
        | World Relief Disaster Preparedness     | 2024-10-06  | Sandakan       | Training for disaster preparedness and response. | World Relief                                  | false |
        | Gebirah Youth Empowerment              | 2024-11-23  | Putrajaya      | Workshops and training for youth empowerment.    | Gebirah                                       | false |
        | CARE Water Sanitation Project          | 2024-12-02  | Petaling Jaya  | Improving water sanitation in rural areas.       | CARE International                            | false |
        | Amnesty Rights Workshop                | 2024-08-25  | Klang          | Workshops on human rights and legal issues.      | Amnesty International                          | false |
        | Oxfam Fundraiser                       | 2024-09-09  | George Town    | Fundraising event for poverty alleviation.       | Oxfam                                         | false |
        | World Vision Child Sponsorship         | 2024-11-30  | Kuantan        | Promoting child sponsorship programs.            | World Vision                                  | false |
        | Human Rights Watch Film Screening      | 2024-09-19  | Bintulu        | Screening of films on human rights issues.       | Human Rights Watch                            | false |
        | IRC Job Fair                           | 2024-10-17  | Labuan         | Job fair for refugees and asylum seekers.        | International Rescue Committee (IRC)           | false |
        | Doctors Without Borders Vaccination Drive | 2024-12-05  | Sibu        | Vaccination drive for children and adults.       | Doctors Without Borders/Médecins Sans Frontières | false |

Scenario: Event Cards ordered by date of event
    Then the event cards displayed should be ordered in ascending order according to date of event
    And I should see "Gebirah Aid Giveaway" before "World Vision Education Fair"

Scenario: Search for Event Card and order by date of event
    When I enter "Gebirah" into the bulletin search bar
    Then I should only see a list of event cards related to "Gebirah"
    And I should see "Gebirah Aid Giveaway" before "Gebirah Youth Empowerment"
