from fastapi import FastAPI

app = FastAPI()

@app.get("/")  
async def hello_world():  
    return {"success": True, "message": "Hello World"}

# run 
# uvicorn fastapi_helloworld:app
# access localhost:8000 to see result