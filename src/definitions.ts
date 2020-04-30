declare module "@capacitor/core" {
  interface PluginRegistry {
    ImageResizer: ImageResizerPlugin;
  }
}

export enum FilesystemDirectory {
  // The Cache directory Can be deleted in cases of low memory, so use this directory to write app-specific files that your app can re-create easily.
  Cache = "CACHE",
  // The Data directory On iOS it will use the Documents directory On Android it's the directory holding application files. Files will be deleted when the application is uninstalled.
  Data = "DATA",
  // The Documents directory On iOS it's the app's documents directory. Use this directory to store user-generated content. On Android it's the Public Documents folder, so it's accessible from other apps. It's not accesible on Android 10 and newer.
  Documents = "DOCUMENTS",
  // The external directory On iOS it will use the Documents directory On Android it's the directory on the primary shared/external storage device where the application can place persistent files it owns. These files are internal to the applications, and not typically visible to the user as media. Files will be deleted when the application is uninstalled.
  External = "EXTERNAL",
  // The external storage directory On iOS it will use the Documents directory On Android it's the primary shared/external storage directory. It's not accesible on Android 10 and newer.
  ExternalStorage = "EXTERNAL_STORAGE",
}


export interface ImageResizeOptions {
  // The FilesystemDirectory to read the file from
  directory?: FilesystemDirectory;
  // The filename to read
  path: string;

  width: number;
  height: number;
  //  overwrite: boolean;
  keepAspectRatio: boolean;
  quality: number;
}

export interface ImageResizerPlugin {
  resizeImage(options: ImageResizeOptions): Promise<{ path: string }>;
}
