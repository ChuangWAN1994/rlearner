% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rlasso.R
\name{predict.rlasso}
\alias{predict.rlasso}
\title{predict for rlasso}
\usage{
\method{predict}{rlasso}(object, newx = NULL, ...)
}
\arguments{
\item{object}{a rlasso object}

\item{newx}{covariate matrix to make predictions on. If null, return the tau(x) predictions on the training data}

\item{...}{additional arguments (currently not used)}
}
\value{
vector of predictions
}
\description{
get estimated tau(x) using the trained rlasso model
}
\examples{
\dontrun{
n = 100; p = 10

x = matrix(rnorm(n*p), n, p)
w = rbinom(n, 1, 0.5)
y = pmax(x[,1], 0) * w + x[,2] + pmin(x[,3], 0) + rnorm(n)

rlasso_fit = rlasso(x, w, y)
rlasso_est = predict(rlasso_fit, x)
}


}
