import asyncio
import websockets
import subprocess

async def on_connect(websocket):
    print(f"Cliente conectado desde {websocket.remote_address}")
    try:
        async for message in websocket:
            print(f"Mensaje recibido: {message}")
            
            if message == 'open_web':
                subprocess.run(["start", "https://www.google.com"], shell=True)
            elif message == 'open_word':
                subprocess.run(["start", "winword"], shell=True)
            elif message == 'open_player':
                subprocess.run(["start", "wmplayer"], shell=True)
                
    except websockets.exceptions.ConnectionClosed as e:
        print(f"Cliente desconectado: {websocket.remote_address} ({e.code}, {e.reason})")
    finally:
        print(f"Conexión cerrada con {websocket.remote_address}")

async def main():
    server = await websockets.serve(on_connect, "0.0.0.0", 8080)
    print("Servidor WebSocket escuchando en ws://0.0.0.0:8080")
    await server.wait_closed()

if __name__ == "__main__":
    asyncio.run(main())