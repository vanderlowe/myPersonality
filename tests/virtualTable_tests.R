require(testthat)

test_that("extractColumn extracts the right information", {
  # Normal cases
  expect_that(extractColumn("foo"), equals("foo"))
  expect_that(extractColumn("foo > 1"), equals("foo"))
  expect_that(extractColumn("foo<1"), equals("foo"))
  expect_that(extractColumn("foo = 1"), equals("foo"))
  expect_that(extractColumn("foo = 'bar'"), equals("foo"))
  expect_that(extractColumn("foo IS NOT 'bar'"), equals("foo"))
  
  # Abnormal cases
  expect_error(extractColumn(c("foo","bar"))) # Because the function is not vectorized (yet).
  expect_error(extractColumn(1)) # Can only process strings
  expect_error(extractColumn()) # Needs input
})

test_that("isWHERE", {
  # Normal cases
  expect_false(isWHERE("bar"))
  expect_true(isWHERE("bar > 1"))
  
  # Abnormal cases
  expect_error(isWHERE())
  expect_error(isWHERE(1))
})

test_that("function arguments get parsed", {
  expect_equal(getFunctionArguments(), NULL)
  expect_equal(getFunctionArguments("foo"), "foo")
  expect_equal(getFunctionArguments(arg1 = "foo"), "foo")
  expect_equal(getFunctionArguments("foo", "bar > 1", foobar = T), c("foo", "bar > 1", "TRUE"))
})

test_that("column names and WHERE statements get parsed from arguments", {
  expect_equal(processFunctionArguments(), NULL)
  expect_equal(processFunctionArguments("foo"), list(columns = "foo"))
  expect_equal(processFunctionArguments("foo > 1"), list(columns = "foo", where = "foo > 1"))
  expect_equal(processFunctionArguments("foo > 1", "bar"), list(columns = c("foo", "bar"), where = "foo > 1"))
})

test_that("participants virtual table can be created", {
  # To test this, you must have a local MySQL version of myPersonality_dev database
  localConfig()
  
  # Normal cases
  expect_output(participants("age"), "SELECT demog.userid,demog.age FROM demog")
  expect_output(participants("age > 18"), "SELECT demog.userid,demog.age FROM demog WHERE demog.age > 18")
  
  # Abnormal cases
  expect_that(participants(), throws_error())
  expect_that(participants("foo"), throws_error()) # Cannot request non-existent variables
  
})

