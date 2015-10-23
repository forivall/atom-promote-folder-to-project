{CompositeDisposable} = require 'atom'
$ = require 'jquery'

module.exports = PromoteFolderToProject =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add '.tree-view.full-menu', 'promote-folder-to-project:add-project-folder': (e) => @addProjectFolder(e)

  deactivate: ->
    @subscriptions.dispose()

  addProjectFolder: (event) ->
    name = $(event.target).closest(".header").find(".name").get(0)
    dirPath = name?.dataset?.path
    if dirPath then atom.project.addPath(dirPath)
