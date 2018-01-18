#  NYC Schools App - Notes, comments
20180117-JS-NYCSchools
Jeff Sanok 01/18/2018

This app connects to a web service to get a list of NYC high schools. When a school is tapped in the tableview, the next view controller connects to a service to get the SAT scores for that school.

There is a search/filter functionality to make it easier for the user to find a particular school in the list.

The architecture is MVC with some added helper components to handle data responsibilities. I would want to refactor the search/filter functionality out of the SchoolsViewController and move it to a view model.

There are some unit test cases that cover core flow, I would want to add more cases around search/filter, etc.
