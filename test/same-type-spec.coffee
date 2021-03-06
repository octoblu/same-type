SameType = require '../src/same-type'

describe 'SameType (object syntax)', ->
  describe '->areAllDates', ->
    describe 'when passed two dates', ->
      beforeEach ->
        @sut = new SameType ['2014-05-02', 'May 07, 2012']

      it 'should return true', ->
        expect(@sut.areAllDates()).to.be.true

    describe 'when passed two numeric things', ->
      beforeEach ->
        @sut = new SameType ['123', 432, '12.3']

      it 'should return true (could be seconds since epoch)', ->
        expect(@sut.areAllDates()).to.be.true

    describe 'when passed two disparate things', ->
      beforeEach ->
        @sut = new SameType ['12', 'orange']

      it 'should return 2 strings', ->
        expect(@sut.areAllDates()).to.be.false

  describe '->areAllNumeric', ->
    describe 'when passed two dates', ->
      beforeEach ->
        @sut = new SameType ['2014-05-02', 'May 07, 2012']

      it 'should return true', ->
        expect(@sut.areAllNumeric()).to.be.false

    describe 'when passed two numeric things', ->
      beforeEach ->
        @sut = new SameType ['123', 432, '12.3']

      it 'should return true', ->
        expect(@sut.areAllNumeric()).to.be.true

    describe 'when passed two disparate things', ->
      beforeEach ->
        @sut = new SameType ['12', 'orange']

      it 'should return 2 strings', ->
        expect(@sut.areAllNumeric()).to.be.false

  describe '->areAllBooleans', ->
    describe 'when passed two booleans', ->
      beforeEach ->
        @sut = new SameType ['true', 'false']

      it 'should return true', ->
        expect(@sut.areAllBooleans()).to.be.true

    describe 'when passed multiple things  that are boolean', ->
      beforeEach ->
        @sut = new SameType ['false', true, 'true']

      it 'should return true', ->
        expect(@sut.areAllBooleans()).to.be.true

    describe 'when passed two disparate things', ->
      beforeEach ->
        @sut = new SameType ['true', 'orange']

      it 'should return 2 strings', ->
        expect(@sut.areAllBooleans()).to.be.false

  describe '->parseBoolean', ->
    describe 'when passed the string "true"', ->
      beforeEach ->
        @sut = new SameType

      it 'should return true', ->
        expect(@sut.parseBoolean 'true').to.be.true

    describe 'when passed the string "false"', ->
      beforeEach ->
        @sut = new SameType

      it 'should return false', ->
        expect(@sut.parseBoolean 'false').to.be.false

        describe 'when passed true', ->
          beforeEach ->
            @sut = new SameType

          it 'should return true', ->
            expect(@sut.parseBoolean true).to.be.true

        describe 'when passed the false', ->
          beforeEach ->
            @sut = new SameType

          it 'should return true', ->
            expect(@sut.parseBoolean false).to.be.false

  describe '->toJSON', ->
    describe 'when passed two dates', ->
      beforeEach ->
        @sut = new SameType ['2014-05-02', 'May 07, 2012']

      it 'should return two ms since epoch', ->
        expect(@sut.toJSON()).to.deep.equal [1398988800000, 1336348800000]

    describe 'when passed a date and undefined', ->
      beforeEach ->
        @sut = new SameType ['2014-05-02', undefined]

      it 'should return the same items', ->
        expect(@sut.toJSON()).to.deep.equal ['2014-05-02', undefined]

    describe 'when passed two numeric things', ->
      beforeEach ->
        @sut = new SameType ['123', 432, '12.3']

      it 'should return 3 floats', ->
        expect(@sut.toJSON()).to.deep.equal [123.0, 432.0, 12.3]

    describe 'when passed two disparate things', ->
      beforeEach ->
        @sut = new SameType ['12', 'orange']

      it 'should return 2 strings', ->
        expect(@sut.toJSON()).to.deep.equal ['12', 'orange']

describe '-> sameType (function syntax)', ->
  beforeEach ->
    @sut = SameType

  it 'should be a function', ->
    @sut()

  describe 'when passed two dates', ->
    beforeEach ->
      @result = @sut ['2014-05-02', 'May 07, 2012']

    it 'should return two ms since epoch', ->
      expect(@result).to.deep.equal [1398988800000, 1336348800000]

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

  describe 'when passed two disparate things', ->
    beforeEach ->
      @result = @sut [true, false]

    it 'should return 2 booleans', ->
      expect(@result).to.deep.equal [true, false]
