## Put comments here that give an overall description of what your
## functions do

## This functions sets and gets the matrix and inverse of a matrix

makeCacheMatrix <- function(x = matrix()) {
  ## set m as empty (will take cached later)
  m <- NULL
  
  ## this function sets the matrix (and resets the cache if new matrix)
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  
  ## this function gets the matrix from the cache
  get <- function() x
  
  ## this function sets the inverse of the matrix
  setinverse <- function(solve) m <<- solve
  
  ## this function gets the inverse from the cache
  getinverse <- function() m
  
  ## this adds functions to a list to make them retrievable
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}

## This function checks to see if the inverse of a matrix has been cached,
## of it has, it returns that, if it hasn't it calculates and stores the result.
## Argument is makeCacheMatrix(x).

cacheSolve <- function(x, ...) {
  m <- x$getinverse()
  if(!is.null(m)) {
    message("matrix inversion - getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setinverse(m)
  m
}

## Example data

mat1 <- matrix(c(1,4,9,0,-3,2,2,7,8),3,3)
mat2 <- matrix(c(4,7,2,6),2,2)
mtrx <- makeCacheMatrix(mat1)
cacheSolve(mtrx)
mtrx <- makeCacheMatrix(mat1)
cacheSolve(mtrx)
mtrx <- makeCacheMatrix(mat2)
cacheSolve(mtrx)


