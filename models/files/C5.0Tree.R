modelInfo <- list(label = "Single C5.0 Tree", 
                  library = "C50",
                  loop = NULL,
                  type = "Classification",
                  parameters = data.frame(parameter = c('parameter'),
                                          class = c("character"),
                                          label = c('none')),
                  grid = function(x, y, len = NULL) data.frame(parameter = "none"),
                  fit = function(x, y, wts, param, lev, last, classProbs, ...) { 
                    theDots <- list(...)
                    argList <- list(x = x, y = y, weights = wts)
                    argList <- c(argList, theDots)
                    do.call("C5.0.default", argList)
                  },
                  predict = function(modelFit, newdata, submodels = NULL) 
                    predict(modelFit, newdata),
                  prob = function(modelFit, newdata, submodels = NULL) 
                    predict(modelFit, newdata, type= "prob"),
                  predictors = function(x, ...) {
                    vars <- C5imp(x, metric = "splits")
                    rownames(vars)[vars$Overall > 0]
                  },
                  varImp = function(object, ...) C5imp(object, ...),
                  tags = c("Tree-Based Model", "Implicit Feature Selection"),
                  sort = function(x) x[order(x[,1]),],
                  trim = function(x) {
                    x$boostResults <- NULL
                    x$size <- NULL
                    x$call <- NULL
                    x$output <- NULL
                    x
                  })
