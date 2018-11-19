
module Main where

--import Lexer (tokenize)
--import Parser (parse)
--import Evaluator (evaluate)

-- import System.IO
-- import System.Environment
import Data.Char
-- import qualified Data.Map as DataMap

-- TODO: Constant constructor can only handle single-character integers
-- TODO: Add enumeration constants
data Constant = IntegerConstant Int
              | CharacterConstant Char
              | FloatingConstant Double
        deriving (Show, Eq)

constant :: String -> Constant
constant [] = error $ "No input"
constant (c : cs) = IntegerConstant (read (c:cs))
    -- | c >= '0' && c <= '9' = IntegerConstant (digitToInt c)
    -- | otherwise         = error $ "Unknown input"

constantToString :: Constant -> String
constantToString (IntegerConstant c) = show c
constantToString (CharacterConstant c) = [c]
constantToString (FloatingConstant c) = show c

data AssignmentOperator = AssignmentRegular
                        | AssignmentPlus
                        | AssignmentMinus
                        | AssignmentTimes
                        | AssignmentDiv
                        | AssignmentModulo
                        | AssignmentShiftLeft
                        | AssignmentShiftRight
                        | AssignmentAnd
                        | AssignmentExp
                        | AssignmentOr
        deriving (Show, Eq)

assignmentOperator :: String -> AssignmentOperator
assignmentOperator str | str == "="   = AssignmentRegular
                       | str == "+="  = AssignmentPlus
                       | str == "-="  = AssignmentMinus
                       | str == "*="  = AssignmentTimes
                       | str == "/="  = AssignmentMinus
                       | str == "%="  = AssignmentModulo
                       | str == "<<=" = AssignmentShiftLeft
                       | str == ">>=" = AssignmentShiftRight
                       | str == "&="  = AssignmentAnd
                       | str == "^="  = AssignmentExp
                       | str == "|="  = AssignmentOr
                       | otherwise    = error $ "Unknown assignment operator: " ++ str

assignmentOperatorToString :: AssignmentOperator -> String
assignmentOperatorToString ao | ao == AssignmentRegular     = "="
                              | ao == AssignmentPlus        = "+="
                              | ao == AssignmentMinus       = "-="
                              | ao == AssignmentTimes       = "*="
                              | ao == AssignmentDiv         = "/="
                              | ao == AssignmentModulo      = "%="
                              | ao == AssignmentShiftLeft   = "<<="
                              | ao == AssignmentShiftRight  = ">>="
                              | ao == AssignmentAnd         = "&="
                              | ao == AssignmentExp         = "^="
                              | ao == AssignmentOr          = "|="
                              | otherwise                   = error $ "Unknown assignment operator"

listAssignmentOperatorStrings :: [String]
listAssignmentOperatorStrings = ["=","+=","-=","*=","/=","%=","<<=",">>=","&=","^=","|="]

data Operator = OperatorPlus
              | OperatorMinus
              | OperatorTimes
              | OperatorDiv
              | OperatorModulo
              | OperatorNegation
              | OperatorLessThan
              | OperatorGreaterThan
              | OperatorAssignment AssignmentOperator
              | OperatorEqualTo
              | OperatorNotEqualTo
              | OperatorGreaterThanOrEqualTo
              | OperatorLessThanOrEqualTo
              | OperatorInclusiveOr
              | OperatorLogicalAnd
              | OperatorLogicalOr
        deriving (Show, Eq)

operator :: String -> Operator
operator str | str == "+" = OperatorPlus
             | str == "-" = OperatorMinus
             | str == "*" = OperatorTimes
             | str == "/" = OperatorDiv
             | str == "%" = OperatorModulo
             | str == "!" = OperatorNegation
             | str == "<" = OperatorLessThan
             | str == ">" = OperatorGreaterThan
             | str == "=="  = OperatorEqualTo
             | str == "!="  = OperatorNotEqualTo
             | str == ">="  = OperatorGreaterThanOrEqualTo
             | str == "<="  = OperatorLessThanOrEqualTo
             | str == "|"  = OperatorInclusiveOr
             | str == "&&"  = OperatorLogicalAnd
             | str == "||"  = OperatorLogicalOr
             | elem str listAssignmentOperatorStrings = OperatorAssignment (assignmentOperator str)
             | otherwise = error $ "Unknown operator"

operatorToString :: Operator -> String
operatorToString op | op == OperatorPlus = "+"
                    | op == OperatorMinus = "-"
                    | op == OperatorTimes = "*"
                    | op == OperatorDiv = "/"
                    | op == OperatorModulo = "%"
                    | otherwise = error $ "Unknown operator"

listOperators :: [String]
listOperators = ["+","-","*","/","%","!","<",">","==","!=",">=","<=","|","&&","||"]

-- TODO: Implement struct-or-union-specifier and enum-specifier
data TypeQualifier = TypeVoid
                   | TypeChar
                   | TypeShort
                   | TypeInt
                   | TypeLong
                   | TypeFloat
                   | TypeDouble
                   | TypeSigned
                   | TypeUnsigned
                   | TypeTypeDef
        deriving (Show, Eq)

typeQualifier :: String -> TypeQualifier
typeQualifier str | str == "void"     = TypeVoid
                  | str == "char"     = TypeChar
                  | str == "short"    = TypeShort
                  | str == "int"      = TypeInt
                  | str == "long"     = TypeLong
                  | str == "float"    = TypeFloat
                  | str == "double"   = TypeDouble
                  | str == "signed"   = TypeSigned
                  | str == "unsigned" = TypeUnsigned
                  | str == "typedef"  = TypeTypeDef
                  | otherwise         = error $ "Unknown type qualifier: " ++ str

typeQualifierToString :: TypeQualifier -> String
typeQualifierToString t | t == TypeVoid = "void"
                        | t == TypeChar = "char"
                        | t == TypeShort = "short"
                        | t == TypeInt = "int"
                        | t == TypeLong = "long"
                        | t == TypeFloat = "float"
                        | t == TypeDouble = "double"
                        | t == TypeSigned = "signed"
                        | t == TypeUnsigned = "unsigned"
                        | t == TypeTypeDef = "typedef"
                        | otherwise = error $ "Unknown type qualifier"

listTypeQualifiers :: [String]
listTypeQualifiers = ["void","char","short","int","long","float","double","signed","unsigned","typedef"]

data Token = TokenIdentifier String
           | TokenConstant Constant
           | TokenOperator Operator
           | TokenTypeQualifier TypeQualifier
           | TokenEndOfLine
        deriving (Show, Eq)

token :: Token
token = TokenIdentifier "a"

showTokenContent :: Token -> String
showTokenContent (TokenIdentifier str) = str
showTokenContent (TokenConstant c) = constantToString c
showTokenContent (TokenOperator op) = operatorToString op
showTokenContent (TokenTypeQualifier t) = typeQualifierToString t
showTokenContent TokenEndOfLine = show ";"

-- TODO: Implement sym function
sym :: String -> (String, String)
sym str = symbols "" str
    where
        symbols acc [] = (acc, [])
        symbols acc (c : cs)
            | isSymbol c =
                let (acc', cs') = symbols acc cs
                in (c:acc', cs')
            | otherwise = (acc, c:cs)

symbol :: Char -> String -> [Token]
symbol c cs =
    let
        (str, cs') = sym cs
    in
        TokenOperator (operator (c:str)) : tokenize cs'

-- TODO: Implement double function
--double :: String -> String -> (String, String)
--double c cs = 

-- TODO: Add type double functionality
digits :: String -> (String, String)
digits str = digs "" str
    where
        digs :: String -> String -> (String, String)
        digs acc [] = (acc, [])
        digs acc (c : cs)
            | isDigit c = let (acc', cs') = digs acc cs
                           in (c:acc', cs')
            -- | c == '.' = 
            | otherwise = (acc, c:cs)

number :: Char -> String -> [Token]
number c cs =
    let (digs, cs') = digits cs
    in TokenConstant (constant (c:digs)) : tokenize cs'

alnums :: String -> (String, String)
alnums str = als "" str
    where
        als acc [] = (acc, [])
        als acc (c:cs)
            | isAlphaNum c =
                let (acc', cs') = als acc cs
                in (c:acc', cs')
            | otherwise = (acc, c:cs)

identifier :: Char -> String -> [Token]
identifier c cs =
    let
        (str, cs') = alnums cs
    in
        if elem (c:str) listTypeQualifiers then
            TokenTypeQualifier (typeQualifier (c:str)) : tokenize cs'
        else
            TokenIdentifier (c:str) : tokenize cs'

tokenize :: String -> [Token]
tokenize [] = []
tokenize (c : cs)
    | isAlpha c = identifier c cs
    | isDigit c = number c cs
    | elem c "+-*/%!=&|<>^" = symbol c cs
    | isSpace c = tokenize cs
    | c == ';' = TokenEndOfLine : tokenize cs
    | otherwise = error $ "Unknown input: " ++ [c]

main :: IO ()
main = do
    print $ constant "3"
    print $ operator "+"
    print $ tokenize "+3"
    print $ tokenize "3 + 2 + 1"
    print $ tokenize "3 = 3"
    print $ tokenize "2 == 2"
    print $ tokenize "27 != 483"
    print $ tokenize "int a = 300;"
