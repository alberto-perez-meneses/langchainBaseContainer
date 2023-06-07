import sys

from flask import Flask, request, jsonify, make_response
from dotenv import load_dotenv
import os
from langchain.llms import OpenAI
from langchain.prompts import PromptTemplate
from langchain.chains import LLMChain

load_dotenv()


api_key = os.getenv("API_KEY")


llm = OpenAI(openai_api_key=os.getenv('OPENAI_API_KEY'),temperature=0.9)

app = Flask(__name__)

def completion(my_message):

    prompt = PromptTemplate(
    input_variables=["texto"],
    template="traduce del español a ingles la siguiente frase: {texto}",)
    chain = LLMChain(llm=llm, prompt=prompt)
    return chain.run(my_message)


@app.route('/message', methods=['POST'])
def get_message():
    data = request.get_json()  # Obtener datos del cuerpo de la solicitud POST
    print(data)
    if(data["key"]==api_key):
        message = data['message']  # Obtener el valor del parámetro 'message'
        response = completion(message)
        return {'message': response}  # Devolver el mismo mensaje en formato JSON
    else:
        return {'message': "acceso denegado"}


@app.errorhandler(404)
def resource_not_found(e):
    return make_response(jsonify(error='Not found!'), 404)