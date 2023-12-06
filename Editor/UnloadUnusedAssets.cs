using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class UnloadUnusedAssets : Editor
{
    [MenuItem("Assets/Unload Unused Assets")]
    static void Unload()
    {
        Resources.UnloadUnusedAssets();

        Debug.Log("Unused assets unloaded");
    }
}
