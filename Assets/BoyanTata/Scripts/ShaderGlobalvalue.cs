using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderGlobalvalue : MonoBehaviour
{
    public Material material;
    // Start is called before the first frame update
    void Start()
    {
        //获取全局变量
        var col = Shader.GetGlobalColor("_DiffuseColor");
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.G))
        {
            Shader.SetGlobalColor("_DiffuseColor", Color.white);
            material.color = Color.green;
        //Shader.SetGlobalColor("_DiffuseColor", Color.green);

        }        
        if (Input.GetKeyDown(KeyCode.R))
        {
            material.color = Color.white;
            Shader.SetGlobalColor("_DiffuseColor", Color.red);

        }        
        if (Input.GetKeyDown(KeyCode.Space))
        {
            material.color = Color.white;
            Shader.SetGlobalColor("_DiffuseColor", Color.white);

        }
        if (Input.GetKeyDown(KeyCode.Q))
        {
            //if (!Shader.IsKeywordEnabled("_branch1"))
            //{
            //    //Shader.DisableKeyword("__");
            //    //Shader.DisableKeyword("_branch2");
            //    Shader.EnableKeyword("_branch1");
            //}
            Shader.EnableKeyword("_branch2");
            Shader.EnableKeyword("_branch1");
            Shader.DisableKeyword("__");
        }
        //激活shader分支
        if (Input.GetKeyDown(KeyCode.W))
        {
            //if (!Shader.IsKeywordEnabled("_branch2"))
            //{
            //   // Shader.DisableKeyword("__");
            //    //Shader.DisableKeyword("_branch1");
            //    Shader.EnableKeyword("_branch2");
            //    Debug.Log(Shader.IsKeywordEnabled("__"));
            //}
            Shader.DisableKeyword("_branch2");
            Shader.DisableKeyword("_branch1");

        }
        if (Input.GetKeyDown(KeyCode.E))
        {

            if (!Shader.IsKeywordEnabled("__"))
            {
                Shader.DisableKeyword("_branch1");
                Shader.DisableKeyword("_branch2");
                Shader.EnableKeyword("__");
                Debug.Log(Shader.IsKeywordEnabled("__"));
            }
        }
    }
}
