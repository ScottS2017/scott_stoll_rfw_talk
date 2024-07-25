# rag_chroma_db

### 1 Start Chroma
- Start Chroma db. In an Anaconda terminal: 
```chroma run --path /db_path --port YOUR_PORT```


- Start ollama. In an Anaconda terminal: ```ollama run YOUR_MODEL``` where your model can be many models. Use llama3 as a starter.


- Use a loader to load your data, examples are at chroma_rag_instructions.dart line 44.


- Split the text into chunks, example is at chroma_rag_instructions.dart line 74.

- Create embeddings, example is at chroma_rag_instructions.dart line 88.


- Create a VectorStore, example is at chroma_rag_instructions.dart line 95.


- Create a Retriever, example is at chroma_rag_instructions.dart line 98.


- Create a prompt from template, example is at chroma_rag_instructions.dart line 107.


- Create the chat LLM, and ensure your URI is correct. If you get errors about "ClientException with SocketException: The semaphore timeout period has expired", the baseURL parameter isn't right. 10.0.2.2 is not correct for Windows apps. Example is at chroma_rag_instructions.dart line 116.


- Create output parser, pipe and chain. Example is at chroma_rag_instructions.dart line 127.

Run it.