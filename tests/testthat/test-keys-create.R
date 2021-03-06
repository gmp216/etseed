context("etseed keys: create")

client <- etcd()

test_that("keys - create basic method works correctly", {
  skip_on_cran()
  skip_on_travis()

  invisible(suppressWarnings(client$delete(key = "/stuff")))

  aa <- client$create(key="/stuff", value="and things")

  expect_is(client$create, "function")
  expect_is(aa, "list")
  expect_named(aa, c('action', 'node'))
  expect_is(aa$action, "character")
  expect_equal(aa$action, "set")
  expect_is(aa$node, "list")
  expect_equal(aa$node$key, "/stuff")
  expect_equal(aa$node$value, "and things")
  expect_is(aa$node$modifiedIndex, "integer")
  expect_is(aa$node$createdIndex, "integer")
})

test_that("keys - create keys with spaces works correctly", {
  skip_on_cran()
  skip_on_travis()

  invisible(suppressWarnings(client$delete(key = "/more stuff")))

  aa <- client$create(key="/more stuff", value="and things")

  expect_is(client$create, "function")
  expect_is(aa, "list")
  expect_named(aa, c('action', 'node'))
  expect_is(aa$action, "character")
  expect_equal(aa$action, "set")
  expect_is(aa$node, "list")
  expect_equal(aa$node$key, "/more stuff")
  expect_equal(aa$node$value, "and things")
  expect_is(aa$node$modifiedIndex, "integer")
  expect_is(aa$node$createdIndex, "integer")
})

test_that("keys - create, ttl param works correctly", {
  skip_on_cran()
  skip_on_travis()

  invisible(suppressWarnings(client$delete(key = "/yeppers")))

  aa <- client$create(key="/yeppers", value="peppers", ttl = 2)

  # key should exist immediately after
  expect_is(client$key(key = "/yeppers"), "list")
  # after sleeping 2 sec, it's gone
  Sys.sleep(3)
  expect_error(client$key(key = "/yeppers"), "Key not found")
})

test_that("keys - create, dir param works correctly", {
  skip_on_cran()
  skip_on_travis()

  invisible(suppressWarnings(client$delete(key = "/thedir", dir = TRUE)))

  aa <- client$create(key = "/thedir", dir = TRUE)

  expect_is(client$create, "function")
  expect_is(aa, "list")
  expect_named(aa, c('action', 'node'))
  expect_is(aa$action, "character")
  expect_equal(aa$action, "set")
  expect_true(aa$node$dir)
  expect_is(aa$node, "list")
  expect_equal(aa$node$key, "/thedir")
  # no value was set, it's a dir
  expect_null(aa$node$value)
  expect_is(aa$node$modifiedIndex, "integer")
  expect_is(aa$node$createdIndex, "integer")
})

test_that("keys - create, dir param works correctly with spaces", {
  skip_on_cran()
  skip_on_travis()

  invisible(suppressWarnings(client$delete(key = "/the dir", dir = TRUE)))

  aa <- client$create(key = "/the dir", dir = TRUE)

  expect_is(client$create, "function")
  expect_is(aa, "list")
  expect_named(aa, c('action', 'node'))
  expect_is(aa$action, "character")
  expect_equal(aa$action, "set")
  expect_true(aa$node$dir)
  expect_is(aa$node, "list")
  expect_equal(aa$node$key, "/the dir")
  # no value was set, it's a dir
  expect_null(aa$node$value)
  expect_is(aa$node$modifiedIndex, "integer")
  expect_is(aa$node$createdIndex, "integer")
})

test_that("keys - create, file param works correctly", {
  skip_on_cran()
  skip_on_travis()

  invisible(suppressWarnings(client$delete(key = "/myfile")))
  cat("hello\nworld", file = "myfile.txt")
  expect_error(client$create(key = "/myfile", file = file),
               "not working yet from files")
  # cleanup
  unlink("myfile.txt")
})

test_that("keys - create, file param works correctly with spaces", {
  skip_on_cran()
  skip_on_travis()

  invisible(suppressWarnings(client$delete(key = "/my file")))
  cat("hello\nworld", file = "my file.txt")
  expect_error(client$create(key = "/my file", file = file),
               "not working yet from files")
  # cleanup
  unlink("my file.txt")
})
