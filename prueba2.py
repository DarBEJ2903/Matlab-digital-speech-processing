from tkinter import ttk
import math
from tkinter import ttk
import numpy as np   
#-------------------------------------------------------------------------------------------
import matplotlib
import matplotlib.pyplot as plt
from matplotlib.pylab import mpl
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg,NavigationToolbar2Tk #NavigationToolbar2TkAgg
#------------------------------------------------------------------------------------------
import tkinter as tk
#------------------------------------------------------------------------------------------
import wave
import scipy.io.wavfile as wavfile
import pyaudio
from doctest import master
 
mpl.rcParams ['font.sans-serif'] = ['SimHei'] #Pantalla china
mpl.rcParams ['axes.unicode_minus'] = False # visualización de signo negativo

class Aplicacion:
    data = []
    
    def __init__(self):
        self.ventana1=tk.Tk()
        self.entradadatos()
        self.canvas1=tk.Canvas(self.ventana1, width=600, height=400, background="white")
        self.canvas1.grid(column=0, row=1)
        self.ventana1.mainloop()

    def entradadatos(self):
        self.lf1=ttk.LabelFrame(self.ventana1,text="Comandos")
        self.lf1.grid(column=0, row=0, sticky="w")
        self.boton1=ttk.Button(self.lf1, text="GRABAR", command=self.grabar)
        self.boton1.grid(column=0, row=3, columnspan=2, padx=5, pady=5, sticky="we")
        self.boton2=ttk.Button(self.lf1, text="PROCESAR", command=self.procesar)
        self.boton2.grid(column=0, row=4, columnspan=2, padx=5, pady=5, sticky="we")
    
    def create_form(self,figure):

                 # Visualice los gráficos dibujados en la ventana de tkinter
        self.canvas=FigureCanvasTkAgg(figure,self.ventana1)
        self.canvas.draw () # La versión anterior usaba el método show (). Después de matplotlib 2.2, ya no se recomienda usar show () en lugar de draw, pero usar show no informará un error y mostrará una advertencia.
        self.canvas.get_tk_widget().pack(side=tk.TOP, fill=tk.BOTH, expand=1)
 
                 # Visualice la barra de herramientas de navegación dibujada por matplotlib en la ventana de tkinter
        toolbar = NavigationToolbar2Tk (self.canvas, self.ventana1)  #matplotlib 2.2 para usar NavigationToolbar2Tk, si usa NavigationToolbar2TkAgg le advertirá
        toolbar.update()
        self.canvas._tkcanvas.pack(side=tk.TOP, fill=tk.BOTH, expand=1)
        
       

    def grabar(self):
    
        global data

        chunk = 1024
        FORMAT = pyaudio.paInt16
        CHANNELS = 1
        RATE = 8000
        RECORD_SECONDS = 5
        samples = (RATE/1024)*RECORD_SECONDS

        p = pyaudio.PyAudio()
        stream = p.open(format=FORMAT,channels=CHANNELS,rate =RATE,input=True,frames_per_buffer=chunk)
        stream1 = p.open(format=FORMAT,channels=CHANNELS,rate =RATE,output=True,frames_per_buffer=chunk)

        print ("grabando")

        arreglo = []
        for i in range(0, int(samples)):
            data = stream.read(chunk)
            arreglo.append(data)
            

        stream.stop_stream()
        stream.close()
        stream1.stop_stream()
        stream1.close()

        wf = wave.open('dato.wav', 'wb')
        wf.setnchannels(CHANNELS)
        wf.setframerate(RATE)
        wf.setsampwidth(p.get_sample_size(FORMAT))
        wf.writeframes(b''.join(arreglo))
        wf.close()
        print ("fin")

        rate, data = wavfile.read("dato.wav")
        data = data/max(data)
        print (rate)

        f=plt.figure(num=2,figsize=(16,12),dpi=80,facecolor="white",edgecolor='green',frameon=True)
        fig1=plt.subplot(1,1,1)

        line1 = fig1.plot (data, color = 'red', linewidth = 3, linestyle = '-')

        self.canvas=FigureCanvasTkAgg(f,self.ventana1)
        self.canvas.draw () # La versión anterior usaba el método show (). Después de matplotlib 2.2, ya no se recomienda usar show () en lugar de draw, pero usar show no informará un error y mostrará una advertencia.
        #self.canvas.get_tk_widget().pack(side=tk.TOP, fill=tk.BOTH, expand=1)
 
                 # Visualice la barra de herramientas de navegación dibujada por matplotlib en la ventana de tkinter
        #toolbar = NavigationToolbar2Tk (self.canvas, self.ventana1)  #matplotlib 2.2 para usar NavigationToolbar2Tk, si usa NavigationToolbar2TkAgg le advertirá
        #toolbar.update()
        self.canvas1._tkcanvas.pack(side=tk.TOP, fill=tk.BOTH, expand=1)

    #plt.figure(1)
    #plt.plot(data)
    #plt.show()
    def procesar(self):
      pass
        
        

aplicacion1=Aplicacion()