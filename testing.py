from src.logger import get_logger
from src.custom_execption import CustomException
import sys


logger = get_logger(__name__)

def devide_number(a,b):
    try:
        result = a/b
        logger.info("Dividing 2 numbers")
        return result
    except Exception as e:
        logger.error("Error occured")
        raise CustomException("Custom Error zero", sys)
    
if __name__=="__main__":
    try:
        logger.info("starting main program")
        devide_number(10,0)
    except CustomException as ce:
        logger.error(str(ce))