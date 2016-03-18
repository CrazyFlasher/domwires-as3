var baseDir = "@@@";
var fileURI = FLfile.platformPathToURI(baseDir + "test.fla");
var jsonURI = FLfile.platformPathToURI(baseDir + "test.json");
fl.openDocument(fileURI);
fl.sourcePath = "../src";
fl.getDocumentDOM().docClass = "com.crazyfm.extensions.flashPhysicsEditor.FlashPhysicsJSONBuilder";
fl.getDocumentDOM().testMovie();
fl.outputPanel.save(jsonURI);
fl.getDocumentDOM().close(false);