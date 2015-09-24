_      = require 'lodash'
moment = require 'moment'

class SameType
  constructor: (@items) ->

  isDate: (value) =>
    moment(value).isValid()

  isNumeric: (value) =>
    return false if _.isNaN parseFloat value
    return (value - parseFloat(value) + 1) >= 0

  parseDate: (date) =>
    moment(date).valueOf()

  parseNumber: (number) =>
    parseFloat number

  toJSON: =>
    return _.map(@items, @parseNumber) if _.all @items, @isNumeric
    return _.map(@items, @parseDate)   if _.all @items, @isDate
    return @items

module.exports = (items) ->
  sameType = new SameType items
  sameType.toJSON()
