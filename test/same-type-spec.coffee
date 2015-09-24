
describe '-> sameType (function syntax)', ->
  beforeEach ->
    @sut = require '../src/same-type'

  it 'should be a function', ->
    @sut()

  describe 'when passed two dates', ->
    beforeEach ->
      @result = @sut ['2014-05-02', 'May 07, 2012']

    it 'should return two ms since epoch', ->
      expect(@result).to.deep.equal [1399014000000, 1336374000000]

  describe 'when passed two numeric things', ->
    beforeEach ->
      @result = @sut ['123', 432, '12.3']

    it 'should return 3 floats', ->
      expect(@result).to.deep.equal [123.0, 432.0, 12.3]

  describe 'when passed two disparate things', ->
    beforeEach ->
      @result = @sut ['12', 'orange']

    it 'should return 2 strings', ->
      expect(@result).to.deep.equal ['12', 'orange']
