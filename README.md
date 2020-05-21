* `ruby app.rb` to start the server to port _3000_
* `ruby integration_tests.rb` to run tests.
* I used Sinatra as it serves perfectly the purpose of this assignment: this way we can keep the application code to the minimum and avoid adding extra complexity to it.
* I decoupled code by having the `app.rb` file which only serves as the controller. It has no knowledge about GitHub and how to retrieve recipes. 
* Business logic is encapsulated inside the `Search` class which handles GitHub API call and returns either `Success` of `Failure`.
  * The returned `search` object exclusively exposes data needed across the application - therefore, we avoid using raw data as returned by Github in our views. *It's not needed* in such a small project, but I wanted to show the approach of code decoupling/separation (in other words, avoiding using objects returned by GitHub outside of the Search class). A better solution, to be put in place in bigger projects, would be to define our Struct (ie: Dry::Struct) which encapsulates data we need across the application.
* I created a `SearchPresenter` which is a decorator taking care of all view logic. This way, the view only defines the structure while contents are defined by the presenter.
* Views are in *HAML*: normally I use *ERB* (because it is more of a standard) but for such small projects HAML helps with programming speed, therefore I used it.
* I created _integration tests_ to make sure the pages are working. In a real life scenario, I would have written _unit tests_, too, but, given the time constraint, I have chosen to write ony the most essential tests (which are integration tests because they prove that the whole system works).
* No GitHub credentials are needed to list public repositories.
* TODO: the application should better handle the case of a user manipulating the URL with a wrong page number. Currently it shows an empty list but in a real life scenario it should redirect to the first or last page.

