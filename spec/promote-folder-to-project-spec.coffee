PromoteFolderToProject = require '../lib/promote-folder-to-project'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "PromoteFolderToProject", ->
  [workspaceElement, activationPromise, treeView] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('promote-folder-to-project')

  describe "when the promote-folder-to-project:add-project-folder event is triggered", ->
    it "adds the selected folder in the tree view", ->
      [treeViewFolder, treeViewFolderLabel] = []
      waitsForPromise -> atom.packages.activatePackage("tree-view").then (pkg) ->
        treeView = pkg.mainModule.treeView

      runs ->
        treeViewFolder = workspaceElement.querySelector '.tree-view.full-menu .project-root .directory > .header'
        treeViewFolderLabel = treeViewFolder.querySelector '.name'
        expect(atom.project.getPaths()).not.toContain(treeViewFolderLabel.dataset.path)

        atom.commands.dispatch treeViewFolder, 'promote-folder-to-project:add-project-folder'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.project.getPaths()).toContain(treeViewFolderLabel.dataset.path)
