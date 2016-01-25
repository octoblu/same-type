_      = require 'lodash'
moment = require 'moment'

class SameType
  constructor: (@items) ->

  areAllDates: =>
    _.all @items, @isDate

  areAllNumeric: =>
    _.all @items, @isNumeric

  areAllBooleans: =>
    _.all @items, @isBoolean

  isDate: (value) =>
    return false unless value?
    moment(new Date(value)).isValid()

  isNumeric: (value) =>
    return false if _.isNaN parseFloat value
    return (value - parseFloat(value) + 1) >= 0

  isBoolean: (value) =>
    return true if value == true
    return true if value == false
    return true if value == 'true'
    return true if value == 'false'
    return false

  parseDate: (date) =>
    moment.utc(date).valueOf()

  parseNumber: (number) =>
    parseFloat number

  toJSON: =>
    return _.map(@items, @parseNumber) if _.all @items, @isNumeric
    return _.map(@items, @parseDate)   if @areAllDates()
    return _.map(@items, @parseBoolean) if @areAllBooleans()
    return @items

module.exports = (items) ->
  return new SameType items if this instanceof arguments.callee

  sameType = new SameType items
  sameType.toJSON()
