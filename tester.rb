require "selenium-webdriver"

driver = Selenium::WebDriver.for :firefox
driver.navigate.to "https://irb.aurora.edu/applications/new"

element = driver.find_element(name: 'user[email]')
element.send_keys "kgrondin01@aurora.edu"
element = driver.find_element(name: 'user[password]')
element.send_keys "password"
element.submit



puts driver.title

sleep(3)
# wait.until { driver.find_element(id: "foo") }
# class_name = element.attribute("class")
driver.navigate.to "https://irb.aurora.edu/applications/new"

element = driver.find_element(name: 'document[phone]')
element.send_keys "800-123-4567"
element = driver.find_element(name: 'document[address]')
element.send_keys "123 Washgington St"

element = driver.find_element(name: 'document[department]')
element.send_keys "Biology"

element = driver.find_element(name: 'document[project_title]')
element.send_keys "Human experimentation"
element = driver.find_element(name: 'document[sponsor_name]')
element.send_keys "Abraham Lincoln"
element = driver.find_element(name: 'document[research_question]')
element.send_keys "How many pizzas can a human physically eat?"
element = driver.find_element(name: 'document[lit_review]')
element.send_keys "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ex dolorem eum, eligendi, praesentium aspernatur nisi eveniet alias laudantium dolor aut vitae enim soluta sunt id consectetur earum dolorum nihil provident!"
element = driver.find_element(name: 'document[procedure]')
element.send_keys "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ex dolorem eum, eligendi, praesentium aspernatur nisi eveniet alias laudantium dolor aut vitae enim soluta sunt id consectetur earum dolorum nihil provident!"

element = driver.find_element(name: 'document[pool_of_subjects]')
element.send_keys "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ex dolorem eum, eligendi, praesentium aspernatur nisi eveniet alias laudantium dolor aut vitae enim soluta sunt id consectetur earum dolorum nihil provident!"


element = driver.find_element(name: 'document[sub_recruitment]')
element.send_keys "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellendus, laborum debitis aspernatur? Vitae quidem ipsam, ipsa distinctio, facilis nihil vel repudiandae harum! Quas asperiores rerum cupiditate commodi id iste neque!"


element = driver.find_element(name: 'document[risks]')
element.send_keys "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ex dolorem eum, eligendi, praesentium aspernatur nisi eveniet alias laudantium dolor aut vitae enim soluta sunt id consectetur earum dolorum nihil provident!"


element = driver.find_element(name: 'document[opt_participation]')
element.send_keys "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ex dolorem eum, eligendi, praesentium aspernatur nisi eveniet alias laudantium dolor aut vitae enim soluta sunt id consectetur earum dolorum nihil provident!"

element = driver.find_element(name: 'document[confidentiality]')
element.send_keys "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ex dolorem eum, eligendi, praesentium aspernatur nisi eveniet alias laudantium dolor aut vitae enim soluta sunt id consectetur earum dolorum nihil provident!"

element = driver.find_element(name: 'document[authorities_consent]')
element.send_keys "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ex dolorem eum, eligendi, praesentium aspernatur nisi eveniet alias laudantium dolor aut vitae enim soluta sunt id consectetur earum dolorum nihil provident!"

element = driver.find_element(name: 'document[subjects_consent]')
element.send_keys "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ex dolorem eum, eligendi, praesentium aspernatur nisi eveniet alias laudantium dolor aut vitae enim soluta sunt id consectetur earum dolorum nihil provident!"

element = driver.find_element(name: 'document[questions_file]')
element.send_keys "/home/kyle/Documents/sample.pdf"

element = driver.find_element(name: 'document[hsr_certificate_file]')
element.send_keys "/home/kyle/Documents/sample.pdf"

element = driver.find_element(name: 'document[advisor_sig]')
element.send_keys "Abraham Lincoln"


element.submit

driver.quit
