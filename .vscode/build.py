import os
import sys
import tkinter as tk
from tkinter import scrolledtext

class NameSelector(tk.Tk):
    def __init__(self, addons, cachedNames, projectFolderPath, outputFolderPath, bikeyPath):
        super().__init__()
        self.title("Component")
        self.geometry("300x600")
        
        self.addons = addons
        self.cachedNames = cachedNames
        self.projectFolderPath = projectFolderPath
        self.outputFolderPath = outputFolderPath
        self.bikeyPath = bikeyPath
        self.check_vars = []
        
        self.create_widgets()

    def create_widgets(self):
        # Create main container frame
        main_frame = tk.Frame(self)
        main_frame.grid(row=0, column=0, sticky='nsew')

        # Create a frame to hold the checkboxes
        checkbox_frame = tk.Frame(main_frame)
        checkbox_frame.grid(row=0, column=0, sticky='nsew', padx=5, pady=5)

        # Add a scrollbar
        scrollbar = tk.Scrollbar(checkbox_frame, orient=tk.VERTICAL)
        scrollbar.pack(side='right', fill='y')

        # Create a canvas to allow scrolling
        canvas = tk.Canvas(checkbox_frame, yscrollcommand=scrollbar.set)
        canvas.pack(side='left', fill='both', expand=True)

        scrollbar.config(command=canvas.yview)

        # Create a frame within the canvas to hold the checkbuttons
        checkbutton_frame = tk.Frame(canvas)
        canvas.create_window((0, 0), window=checkbutton_frame, anchor='nw')

        # Add checkbuttons for each name
        for addon in self.addons:
            var = tk.BooleanVar()
            var.set(addon in self.cachedNames)
            chk = tk.Checkbutton(checkbutton_frame, text=addon, variable=var)
            chk.pack(anchor='w')
            self.check_vars.append((addon, var))

        # Update the scroll region
        checkbutton_frame.update_idletasks()
        canvas.config(scrollregion=canvas.bbox('all'))

        # Create submit button
        submit_btn = tk.Button(main_frame, text="Submit", command=self.submit)
        submit_btn.grid(row=1, column=0, sticky='ew', padx=5, pady=5)

        # Create output label
        output_label = tk.Label(main_frame, text="Build Output", font=('Arial', 10, 'bold'))
        output_label.grid(row=2, column=0, sticky='w', padx=5, pady=(5,0))

        # Create output text box
        self.output_text = scrolledtext.ScrolledText(main_frame, height=8, wrap=tk.WORD)
        self.output_text.grid(row=3, column=0, sticky='nsew', padx=5, pady=(0,5))

        # Configure the grid weights
        main_frame.grid_rowconfigure(0, weight=3)  # Checkbox area gets more space
        main_frame.grid_rowconfigure(1, weight=0)  # Submit button
        main_frame.grid_rowconfigure(2, weight=0)  # Output label
        main_frame.grid_rowconfigure(3, weight=1)  # Output text area
        main_frame.grid_columnconfigure(0, weight=1)

        # Configure the main window grid
        self.grid_rowconfigure(0, weight=1)
        self.grid_columnconfigure(0, weight=1)

    def submit(self):
        selected_names = [name for name, var in self.check_vars if var.get()]
        self.output_text.delete(1.0, tk.END)  # Clear previous output
        self.compile(selected_names)

    def compile(self, addons: list[str]):
        output = ""
        for addon in addons:
            build_command = f'AddonBuilder "{os.path.join(self.projectFolderPath, addon)}" "{os.path.join(self.projectFolderPath, self.outputFolderPath)}" -packonly -sign="{self.bikeyPath}"'
            if os.system(build_command) == 0:
                output += f'Successful build: {addon.upper()}\n'
            else:
                output += f'Failed to build: {addon.upper()}\n'
            
            # Update the text widget as each addon is processed
            self.output_text.delete(1.0, tk.END)
            self.output_text.insert(tk.END, output)
            self.output_text.see(tk.END)  # Auto-scroll to the bottom
            self.update()  # Update the GUI

        # Save the cache
        cacheFilepath = os.path.join(self.projectFolderPath, '.vscode', 'compileCache.txt')
        with open(cacheFilepath, "w") as f:
            cacheContent = '\n'.join(addons)
            f.write(cacheContent)

def main():
    projectFolderPath: str = sys.argv[1]
    outputFolderPath: str = sys.argv[2]
    bikeyPath: str = sys.argv[3]
    doQuickBuild = len(sys.argv) >= 5
    addonNames = [f.name for f in os.scandir(projectFolderPath) if f.is_dir()]
    addonNames.remove('.vscode')
    cachedNames = []
    cacheFilepath = os.path.join(projectFolderPath, '.vscode', "compileCache.txt")
    if (os.path.exists(cacheFilepath)):
        with open(cacheFilepath, "r") as f:
            cachedNames = f.read().splitlines()
    
    if doQuickBuild:
        app = NameSelector(addonNames, cachedNames, projectFolderPath, outputFolderPath, bikeyPath)
        if len(cachedNames) > 0:
            app.compile(cachedNames)
        else:
            app.output_text.insert(tk.END, "Failed to Quickbuild: there is no cache to do a quickbuild with")
        app.after(3000, app.destroy)  # Close after 3 seconds for quickbuild
        app.mainloop()
    else:
        app = NameSelector(addonNames, cachedNames, projectFolderPath, outputFolderPath, bikeyPath)
        app.mainloop()

if __name__ == "__main__":
    if (len(sys.argv) < 4):
        print("""
            Invalid number of args\n
            Arg1: Workspace folder
            Arg2: Output folder
            Arg3: Path to biprivatekey
        """)
        sys.exit(1)

    main()