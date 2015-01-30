class UserClass():

    String_emailIdentifier = '@'
    String_emailVerify = 'XXXXXX.edu'
    String_studentIdentifier = '@XXXXXX.edu'
    String_instructorIdentifier = '@XXXXXX.edu'

    def __init__(self, String_email):
        self.String_email = String_email

    def isEmail(self):
        if ( self.String_email.find(UserClass.String_emailIdentifier) > -1 ):
            return True
        else:
            return False

    def isValidEmail(self):
        if self.isEmail():
            if ( self.String_email.find(UserClass.String_emailVerify)> -1 ):
                return True
            else:
                return False
        else:
            return False

    def isStudent(self):
        if self.isValidEmail():
            if (self.String_email.find(UserClass.String_studentIdentifier) > -1):
                return True
            else:
                return False
        else:
            return False

    def isInstructor(self):
        if self.isValidEmail():
            if (self.String_email.find(UserClass.String_instructorIdentifier) > -1):
                return True
            else:
                return False
        else:
            return False