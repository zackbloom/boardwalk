class Boardwalk.Routers.Users extends Backbone.Router
  routes:
    '': 'new'
    'users': 'index'
    'users/:id': 'show'

  before:
    '': ->
      layout = new Boardwalk.Views.DefaultLayout()
      $('body').prepend(layout.render().el)

  initialize: ->
    @collection = new Boardwalk.Collections.Users()

  index: ->
    @collection.fetch()
    view = new Boardwalk.Views.UsersIndex(collection: @collection)
    Boardwalk.setTitle "User index"

    Boardwalk.content(view.render().el)

  new: ->
    view = new Boardwalk.Views.UsersNew(collection: @collection)
    Boardwalk.content(view.render().el)

  show: (id) ->
    user = new Boardwalk.Models.User id: id

    user.fetch
      success: ->
        view = new Boardwalk.Views.UsersShow(model: user)
        Boardwalk.setTitle(_.string.titleize(user.get('username')))
        Boardwalk.content(view.render().el)
