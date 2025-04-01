import requests
import os
import zipfile
from bs4 import BeautifulSoup

def encontrar_links_pdf(html):
    soup = BeautifulSoup(html, 'html.parser')
    links = []
    for link in soup.find_all('a', href=True):
        href = link['href']
        # Filtra apenas links que contenham "Anexo_I" ou "Anexo_II" e terminem com .pdf
        if ('Anexo_I' in href or 'Anexo_II' in href) and href.lower().endswith('.pdf'):
            links.append(href)
    return links

def baixar_anexos():
    print("Iniciando o download dos anexos...")
    url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"
    headers = {'User-Agent': 'Mozilla/5.0'}

    try:
        resposta = requests.get(url, headers=headers)
        resposta.raise_for_status()
        
        links_pdf = encontrar_links_pdf(resposta.text)
        if not links_pdf:
            raise Exception("Nenhum link de PDF encontrado para os anexos.")
        
        os.makedirs("downloads", exist_ok=True)
        arquivos_baixados = []
        
        for link in links_pdf:
            nome_arquivo = link.split("/")[-1]
            caminho_arquivo = os.path.join("downloads", nome_arquivo)
            
            print(f"Baixando {nome_arquivo}...")
            resposta_arquivo = requests.get(link, headers=headers)
            resposta_arquivo.raise_for_status()

            # Verifica se o conteúdo é um PDF (opcional, mas recomendado)
            content_type = resposta_arquivo.headers.get('Content-Type', '')
            if 'application/pdf' not in content_type:
                print(f"Atenção: {nome_arquivo} não é um PDF (Content-Type: {content_type}). Pulando...")
                continue
            
            with open(caminho_arquivo, "wb") as f:
                f.write(resposta_arquivo.content)
            
            arquivos_baixados.append(caminho_arquivo)
            print(f"{nome_arquivo} baixado com sucesso!")
        
        print("Compactando os arquivos...")
        with zipfile.ZipFile("anexos.zip", "w") as zipf:
            for arquivo in arquivos_baixados:
                zipf.write(arquivo, os.path.basename(arquivo))
        
        print("Processo concluído! Apenas PDFs foram baixados e compactados.")

    except Exception as e:
        print(f"Erro: {e}")

if __name__ == "__main__":
    baixar_anexos()