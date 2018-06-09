#' Title
#'
#' @param X
#' @param Y
#' @param W
#' @param alpha
#' @param nfolds.1
#' @param nfolds.0
#' @param lambda.choice
#'
#' @return
#' @export
#'
#' @examples
tboost = function(X, Y, W,
                  alpha = 1,
                  nfolds.1=NULL,
                  nfolds.0=NULL,
                  lambda.choice=c("lambda.min", "lambda.1se")) {

  lambda.choice = match.arg(lambda.choice)

  X.1 = X[which(W==1),]
  X.0 = X[which(W==0),]

  Y.1 = Y[which(W==1)]
  Y.0 = Y[which(W==0)]

  nobs.1 = nrow(X.1)
  nobs.0 = nrow(X.0)

  pobs = ncol(X)

  if (is.null(nfolds.1)) {
    nfolds.1 = floor(max(3, min(10,nobs.1/4)))
  }

  if (is.null(nfolds.0)) {
    nfolds.0 = floor(max(3, min(10,nobs.0/4)))
  }

  t.1.fit = cvboost(X.1, Y.1, objective="reg:linear", nfolds = nfolds.1)
  t.0.fit = cvboost(X.0, Y.0, objective="reg:linear", nfolds = nfolds.0)

  y.1.pred = predict(t.1.fit, newx=X)
  y.0.pred = predict(t.0.fit, newx=X)

  tau.hat = y.1.pred - y.0.pred

  ret = list(t.1.fit = t.1.fit,
             t.0.fit = t.0.fit,
             y.1.pred = y.1.pred,
             y.0.pred = y.0.pred,
             tau.hat = tau.hat)
  class(ret) <- "tboost"
  ret
}

#' Title
#'
#' @param object
#' @param newx
#' @param ...
#'
#' @return
#' @export predict.tboost
#'
#' @examples
predict.tboost <- function(object,
                           newx=NULL,
                           ...) {
  if (!is.null(newx)) {
    y.1.pred = predict(object$t.1.fit, newx=newx)
    y.0.pred = predict(object$t.0.fit, newx=newx)
    tau.hat = y.1.pred - y.0.pred
  }
  else {
    tau.hat = object$tau.hat
  }
  return(tau.hat)
}