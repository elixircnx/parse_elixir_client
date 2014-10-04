defmodule ParseClient do
  @moduledoc """
  REST API client for Parse in Elixir

  ## Example usage

  To get information about a class (and print out the whole response):

      ParseClient.get("classes/Lumberjacks")

  To just see the body, use the `query` function:

      ParseClient.query("classes/Lumberjacks")

  To create a new object, use the `post` function, to update an object, use
  the `put` function, and to delete an object, use the `delete` function.

  ## Use of filters when making queries

  Queries can be filtered by using *filters* and *options*.

  Use filters when you would use `where=` clauses in a request to the Parse API.
  Options include "order", "limit", "count" and "include".

  Both filters and options need to be Elixir maps.

  ## Comparisons in filters

  The following filters (keys) from Parse.com are supported:

  Key | Operation
  --- | ---
  $lt | Less than
  $lte | Less than or equal to
  $gt | Greater than
  $gte | Greater than or equal to
  $ne | Not equal to
  $in | Contained in
  $nin | Not contained in
  $exists | A value is set for the key
  $select | This matches a value for a key in the result of a different query
  $dontSelect | Requires that a key's value not match a value for a key in the result of a different query
  $all | Contains all of the given values

  ### Examples

  To make a query just about animals that are aged less then 3 years old:

      ParseClient.query("classes/Animals", %{"age" => %{"$lt" => 3}})

  To make a query just about animals who have a name and are still alive:

      ParseClient.query("classes/Animals", %{"name" => %{"$exists" => true}, "status" => 1})
  """
end
