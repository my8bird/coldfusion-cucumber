component {

    public void function givenPrecondition(isIsNot, condition) matcher="^precondition (is|is not) (.*)$" {
        throw(message = "something bad happened ruh roh: " & isisnot & ' ' & condition);
    }

    public void function thenSomethingHappens() matcher="something happens" {

    }

    public void function antherSetupPiece() matcher="another setup piece" {

    }

    public void function soIsThis() matcher="so is this" {

    }
}
