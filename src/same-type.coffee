_      = require 'lodash'
moment = require 'moment'

class SameType
  constructor: (@items) ->

  areAllDates: =>
    _.all @items, @isDate

  areAllNumeric: =>
    _.all @items, @isNumeric

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
    return _.map(@items, @parseDate)   if @areAllDates()
    return @items

module.exports = (items) ->
  return new SameType items if this instanceof arguments.callee

  sameType = new SameType items
  sameType.toJSON()
